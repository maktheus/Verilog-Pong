module DecodificadorDisplaySeteSegmentos(in, display2, display1);
input [4:0]in;
output reg [6:0] display2,display1;

	parameter zero = 7'b1000000;
	parameter um = 7'b1111001;
	parameter dois = 7'b0100100;
	parameter tres = 7'b0110000;
	parameter quatro = 7'b0011001;
	parameter cinco = 7'b0010010;
	parameter seis = 7'b0000010;
	parameter sete = 7'b1111000;
	parameter oito = 7'b0000000;
	parameter nove = 7'b0011000;
		
	parameter vazio = 7'b1111111;
	
	always@(*) begin
	case(in)
		0:		begin
				display1 <= zero;
				display2 <= vazio;
				end
		1:		begin
				display1 <= um;
				display2 <= vazio;
				end
		2:		begin
				display1 <= dois;
				display2 <= vazio;
				end
		3:		begin
				display1 <= tres;
				display2 <= vazio;
				end
		4:		begin
				display1 <= quatro;
				display2 <= vazio;
				end
		5:		begin
				display1 <= cinco;
				display2 <= vazio;
				end
		6:		begin
				display1 <= seis;
				display2 <= vazio;
				end
		7:		begin
				display1 <= sete;
				display2 <= vazio;
				end
		8:		begin
				display1 <= oito;
				display2 <= vazio;
				end
		9:		begin
				display1 <= nove;
				display2 <= vazio;
				end
		10:	begin
				display1 <= zero;
				display2 <= um;
				end
		11:	begin
				display1 <= um;
				display2 <= um;
				end
		12:	begin
				display1 <= dois;
				display2 <= um;
				end
		13:	begin
				display1 <= tres;
				display2 <= um;
				end
		14:	begin
				display1 <= quatro;
				display2 <= um;
				end
		15:	begin
				display1 <= cinco;
				display2 <= um;
				end
	endcase
	end
	
endmodule
	

module VGAController (ClockDoPixel,
							 Vermelho,
							 Verde,
							 Azul,
							 VermelhoSaida,
							 VerdeSaida,
							 azulSaida,
							 SincronizacaoVerticalDeSaida,
							 SincronizacaoVerticalDeSaida,
							 PosicaoX,
							 PosicaoY);

parameter XLimit = 1688;
parameter XVisible = 1280;
parameter PulsoSincronizadoDeX = 112;
parameter XBackPorch = 248;

parameter YLimit = 1066;
parameter YVisible = 1024;
parameter PulsoSincronizadoDeY = 3;
parameter YBackPorch = 38;

input ClockDoPixel;
input [7:0] Vermelho;
input [7:0] Verde;
input [7:0] Azul;
output [7:0] VermelhoSaida;
output [7:0] VerdeSaida;
output [7:0] azulSaida;
output SincronizacaoVerticalDeSaida;
output SincronizacaoVerticalDeSaida;
output [10:0] PosicaoX;
output [10:0] PosicaoY;

reg [10:0] TempoDeX;
reg [10:0] TempoDeY;
reg SincronizacaoHorizontal;
reg SincronizacaoVertical;

assign PosicaoX = TempoDeX - (PulsoSincronizadoDeX + XBackPorch);
assign PosicaoY = TempoDeY - (PulsoSincronizadoDeY + YBackPorch);


always@(posedge ClockDoPixel)
begin
	if (TempoDeX >= XLimit)
		TempoDeX <= 11'd0;
	else
		TempoDeX <= TempoDeX + 1;
end
	
always@(posedge ClockDoPixel)
begin
	if (TempoDeY >= YLimit && TempoDeX >= XLimit)
		TempoDeY <= 11'd0;
	else if (TempoDeX >= XLimit && TempoDeY < YLimit)
		TempoDeY <= TempoDeY + 1;
	else
		TempoDeY <= TempoDeY;
end

always@(posedge ClockDoPixel)
begin
	if (TempoDeY >= 0 && TempoDeY < PulsoSincronizadoDeY)
		SincronizacaoVertical <= 1'b0;
	else
		SincronizacaoVertical <= 1'b1;
end
	
always@(posedge ClockDoPixel)
begin
	if (TempoDeX >= 0 && TempoDeX < PulsoSincronizadoDeX)
		SincronizacaoHorizontal <= 1'b0;
	else
		SincronizacaoHorizontal <= 1'b1;
end
	

assign VermelhoSaida = (TempoDeX >= (PulsoSincronizadoDeX + XBackPorch) && TempoDeX <= (PulsoSincronizadoDeX + XBackPorch + XVisible)) ? Vermelho : 8'b0;
assign VerdeSaida = (TempoDeX >= (PulsoSincronizadoDeX + XBackPorch) && TempoDeX <= (PulsoSincronizadoDeX + XBackPorch + XVisible)) ? Verde : 8'b0;
assign azulSaida = (TempoDeX >= (PulsoSincronizadoDeX + XBackPorch) && TempoDeX <= (PulsoSincronizadoDeX + XBackPorch + XVisible)) ? Azul : 8'b0;

assign SincronizacaoVerticalDeSaida = SincronizacaoVertical;
assign SincronizacaoVerticalDeSaida = SincronizacaoHorizontal;

initial
begin
	TempoDeX = 11'b0;
	TempoDeY = 11'b0;
	SincronizacaoHorizontal = 1'b1;
	SincronizacaoVertical = 1'b1;
end
	
endmodule



module DE2_115(
	
	CLOCK_50,
	CLOCK2_50,
	CLOCK3_50,

	LEDG,
	LEDR,

	KEY,

	SW,

	HEX0,
	display1,
	display2,
	HEX3,
	HEX4,
	HEX5,
	HEX6,
	HEX7,

	VGA_B,
	VGA_vazio_N,
	VGA_CLK,
	VGA_G,
	VGA_HS,
	VGA_R,
	VGA_SYNC_N,
	VGA_VS 
);


input		          		CLOCK_50;
input		          		CLOCK2_50;
input		          		CLOCK3_50;

output		     [8:0]		LEDG;
output		    [17:0]		LEDR;


input		     [3:0]		KEY;


input		    [17:0]		SW;


output		     [6:0]		HEX0;
output		     [6:0]		display1;
output		     [6:0]		display2;
output		     [6:0]		HEX3;
output		     [6:0]		HEX4;
output		     [6:0]		HEX5;
output		     [6:0]		HEX6;
output		     [6:0]		HEX7;


output		     [7:0]		VGA_B;
output		          		VGA_vazio_N;
output		          		VGA_CLK;
output		     [7:0]		VGA_G;
output		          		VGA_HS;
output		     [7:0]		VGA_R;
output		          		VGA_SYNC_N;
output		          		VGA_VS;




reg	aresetPll = 0; 
wire 	ClockDoPixel;
wire	[10:0] XPixelPosition;
wire	[10:0] YPixelPosition; 
reg	[7:0] ValorDoVermelho;
reg	[7:0] ValorDoVerde;
reg	[7:0] ValorDoAzul;

reg	[1:0] movimento = 0;
parameter r = 15;


reg 	[20:0] ClkLentoCounter = 0;
wire 	ClkLento;


reg 	[20:0] ClkRapidoCounter = 0;
wire 	ClkRapido;


reg	[10:0] PosicaoXDaBolsa = 500;
reg	[10:0] PosicaoYDaBola = 500; 


reg	[10:0] P1x = 225;
reg	[10:0] Player1y = 500;


reg	[10:0] P2x = 1030;
reg	[10:0] Player2y = 500;


reg 	[3:0] PlacaPlayer1 = 0;
reg		[3:0] PlacarPlayer2 = 0;
reg 	flag =1'b0;




assign VGA_vazio_N = 1'b1;
assign VGA_SYNC_N = 1'b1;			
assign VGA_CLK = ClockDoPixel;



assign LEDR[10:0] = SW[1] ? PosicaoYDaBola : PosicaoXDaBolsa; 



assign ClkLento = ClkLentoCounter[16]; 

always@ (posedge CLOCK_50) 
begin
	ClkLentoCounter <= ClkLentoCounter + 1;
end

assign ClkRapido = ClkRapidoCounter[17]; 

always@ (posedge CLOCK_50) 
begin
	ClkRapidoCounter <= ClkRapidoCounter + 1;
end

always@(posedge ClkRapido) 
begin
if (SW[0] == 1'b0) 
begin
	if (KEY[2] == 1'b0 && KEY[3] == 1'b0) 
		Player1y <= Player1y;
	else if (KEY[2] == 1'b0) begin
		if (Player1y+125 >896)
			Player1y <= 771;
		else
		Player1y <= Player1y + 3;
		end
	else if (KEY[3] == 1'b0) begin
		if(Player1y < 128)
			Player1y <= 128;
		else
		Player1y <= Player1y - 3;
		end
end
else if (SW[0] == 1'b1 || flag==1)
Player1y <= 500;

end

always@(posedge ClkRapido) 
begin
if (SW[0] == 1'b0) 
begin
	if (KEY[0] == 1'b0 && KEY[1] == 1'b0) 
		Player2y <= Player2y;
	else if (KEY[0] == 1'b0) begin
		if(Player2y+125 > 896)
			Player2y <= 771;
		else
		Player2y <= Player2y + 3;
		end
	else if (KEY[1] == 1'b0) begin
		if(Player2y < 128)
			Player2y <= 128;
		else
		Player2y <= Player2y - 3;
		end
end
else if (SW[0] == 1'b1 || flag ==1)
	Player2y <= 500;
end

always@(posedge ClkLento) 
begin
if (SW[0] == 1'b0)
	begin
	case(movimento)
		0:		begin 
				PosicaoXDaBolsa <= PosicaoXDaBolsa + 1;
				PosicaoYDaBola <= PosicaoYDaBola - 1;
				end
		1:		begin 
				PosicaoXDaBolsa <= PosicaoXDaBolsa + 1;
				PosicaoYDaBola <= PosicaoYDaBola + 1;
				end
		2:		begin 
				PosicaoXDaBolsa <= PosicaoXDaBolsa - 1;
				PosicaoYDaBola <= PosicaoYDaBola + 1;
				end
		3:		begin 
				PosicaoXDaBolsa <= PosicaoXDaBolsa - 1;
				PosicaoYDaBola <= PosicaoYDaBola - 1;
				end
	endcase
	
	if(PosicaoYDaBola - r <= 128 && movimento == 0) 
		movimento = 1;
	else if (PosicaoYDaBola - r <= 128 && movimento == 3)
		movimento = 2;
	else if (PosicaoYDaBola + r >= 896 && movimento == 1)	
		movimento = 0;
	else if (PosicaoYDaBola + r >= 896 && movimento == 2) 
		movimento = 3;
	else if (PosicaoXDaBolsa -r <= P1x+25 && PosicaoYDaBola > Player1y && PosicaoYDaBola < Player1y+125 &&  movimento == 2)
		movimento = 1;
	else if (PosicaoXDaBolsa -r<= P1x+25 && PosicaoYDaBola > Player1y && PosicaoYDaBola < Player1y+125 &&  movimento == 3)
		movimento = 0;
	else if (PosicaoXDaBolsa + r >= P2x && PosicaoYDaBola > Player2y && PosicaoYDaBola < Player2y+125 &&  movimento == 1)
		movimento = 2;
	else if (PosicaoXDaBolsa + r >= P2x && PosicaoYDaBola > Player2y && PosicaoYDaBola < Player2y+125 &&  movimento == 0)
		movimento = 3;
	else if (PosicaoXDaBolsa - r <= 160) begin
		PlacarPlayer2 = PlacarPlayer2 + 1;
		
		PosicaoXDaBolsa <= 640;
		PosicaoYDaBola <= 512;
		end
	else if (PosicaoXDaBolsa + r >= 1120)begin
		PlacaPlayer1 = PlacaPlayer1 + 1;
		
		PosicaoXDaBolsa <= 640;
		PosicaoYDaBola <= 512;
		end

		if(PlacaPlayer1 == 10 || PlacarPlayer2 ==10) begin
			PlacaPlayer1<=0;
			PlacarPlayer2<=0;
			flag <=1;
			end
end
else 
	begin
	PosicaoXDaBolsa <= 500;
	PosicaoYDaBola <= 500;
	PlacaPlayer1 <= 0;
	PlacarPlayer2 <= 0;
	end
	
end



VGAFrequency VGAFreq (aresetPll, CLOCK_50, ClockDoPixel);

VGAController VGAControl (ClockDoPixel, ValorDoVermelho, ValorDoVerde, ValorDoAzul, VGA_R, VGA_G, VGA_B, VGA_VS, VGA_HS, XPixelPosition, YPixelPosition);



always@ (posedge ClockDoPixel)
begin		
	begin
		if (XPixelPosition < 160) 
		begin
			ValorDoVermelho <= 8'b11111111; 
			ValorDoAzul <= 8'b11111111;
			ValorDoVerde <= 8'b11111111;
		end
		else if (XPixelPosition > 1120) 
		begin
			ValorDoVermelho <= 8'b11111111; 
			ValorDoAzul <= 8'b11111111;
			ValorDoVerde <= 8'b11111111;
		end

		else if (YPixelPosition < 128 && XPixelPosition > 150 && XPixelPosition < 1420) begin 
			
			if(XPixelPosition > 170 && XPixelPosition < 200) begin 
				ValorDoVermelho <= 8'b11111111; 
				ValorDoAzul <= 8'b00000000;
				ValorDoVerde <= 8'b11111111;
			end
			else if(XPixelPosition > 220 && XPixelPosition < 250) begin
				ValorDoVermelho <= 8'b11111111; 
				ValorDoAzul <= 8'b00000000;
				ValorDoVerde <= 8'b11111111;
			end
			else if(XPixelPosition > 170 && XPixelPosition < 250 && YPixelPosition < 128 &&  YPixelPosition > 90) begin
				ValorDoVermelho <= 8'b11111111; 
				ValorDoAzul <= 8'b00000000;
				ValorDoVerde <= 8'b11111111;
			end
			else if(XPixelPosition > 280 && XPixelPosition < 310) begin 
				ValorDoVermelho <= 8'b11111111; 
				ValorDoAzul <= 8'b00000000;
				ValorDoVerde <= 8'b11111111;
			end

			else if(XPixelPosition > 300 && XPixelPosition < 340 && YPixelPosition <30) begin 
			
				ValorDoVermelho <= 8'b11111111; 
				ValorDoAzul <= 8'b00000000;
				ValorDoVerde <= 8'b11111111;
			end

			else if(XPixelPosition > 300 && XPixelPosition < 340 && YPixelPosition > 50 && YPixelPosition < 80 ) begin 
			
				ValorDoVermelho <= 8'b11111111; 
				ValorDoAzul <= 8'b00000000;
				ValorDoVerde <= 8'b11111111;
			end

			
			else if(XPixelPosition > 370 && XPixelPosition < 400) begin
				ValorDoVermelho <= 8'b11111111;
				ValorDoAzul <= 8'b00000000;
				ValorDoVerde <= 8'b11111111;
			end
			else if(XPixelPosition > 430 && XPixelPosition <460) begin
				ValorDoVermelho <= 8'b11111111; 
				ValorDoAzul <= 8'b00000000;
				ValorDoVerde <= 8'b11111111;
			end

			else if(XPixelPosition > 370 && XPixelPosition <460 &&  YPixelPosition < 30) begin
				ValorDoVermelho <= 8'b11111111; 
				ValorDoAzul <= 8'b00000000;
				ValorDoVerde <= 8'b11111111;
			end

			else if(XPixelPosition > 370 && XPixelPosition <460  && YPixelPosition > 50 && YPixelPosition < 80 ) begin
				ValorDoVermelho <= 8'b11111111; 
				ValorDoAzul <= 8'b00000000;
				ValorDoVerde <= 8'b11111111;
			end

			
			else if(XPixelPosition > 490 && XPixelPosition < 520) begin
				ValorDoVermelho <= 8'b11111111; 
				ValorDoAzul <= 8'b00000000;
				ValorDoVerde <= 8'b11111111;
			end
			else if(XPixelPosition > 550 && XPixelPosition < 580) begin
				ValorDoVermelho <= 8'b11111111; 
				ValorDoAzul <= 8'b00000000;
				ValorDoVerde <= 8'b11111111;
			end
			
			else if(XPixelPosition > 520 && XPixelPosition < 535 && YPixelPosition > 30 && YPixelPosition < (30 + XPixelPosition - 520)) begin
				ValorDoVermelho <= 8'b11111111; 
				ValorDoAzul <= 8'b00000000;
				ValorDoVerde <= 8'b11111111;
			end

			
			else if(XPixelPosition >= 535 && XPixelPosition < 550 && YPixelPosition > 30 && YPixelPosition < (80 - (XPixelPosition - 535))) begin
				ValorDoVermelho <= 8'b11111111; 
				ValorDoAzul <= 8'b00000000;
				ValorDoVerde <= 8'b11111111;
			end


			else begin	
				ValorDoVermelho <= 8'b11111111; 
				ValorDoAzul <= 8'b11111111;
				ValorDoVerde <= 8'b11111111;
					
			end
		end
		else if (XPixelPosition < 1420 && XPixelPosition > 150 && YPixelPosition > 896) 
		begin
			ValorDoVermelho <= 8'b11111111; 
			ValorDoAzul <= 8'b11111111;
			ValorDoVerde <= 8'b11111111;
		end

		else if (XPixelPosition > P1x && XPixelPosition < P1x+25 && YPixelPosition > Player1y && YPixelPosition < Player1y+125) 
		begin
			ValorDoVermelho <= 8'b11111111; 
			ValorDoAzul <= 8'b111111111;
			ValorDoVerde <= 8'b11111111;
		end
		else if (XPixelPosition > P2x && XPixelPosition < P2x+25 && YPixelPosition > Player2y && YPixelPosition < Player2y+125) 
		begin
			ValorDoVermelho <= 8'b11111111; 
			ValorDoAzul <= 8'b11111111;
			ValorDoVerde <= 8'b11111111;
		end
		
		
		else if (((XPixelPosition-PosicaoXDaBolsa)**2 
						+ (YPixelPosition-PosicaoYDaBola)**2) < 15**2) 
		begin
			ValorDoVermelho <= 8'b11111111; 
			ValorDoAzul <= 8'b11111111;
			ValorDoVerde <= 8'b11111111;
		end
		

		else 
		begin
			ValorDoVermelho <= 8'b00000000; 
			ValorDoAzul <= 8'b00000000;
			ValorDoVerde <= 8'b00000000;
		end
	end
end

DecodificadorDisplaySeteSegmentos p1(PlacaPlayer1, HEX7, HEX6);
DecodificadorDisplaySeteSegmentos p2(PlacarPlayer2, HEX5, HEX4);

endmodule


//Exemplo Altera
module VGAFrequency (
	areset,
	inclk0,
	c0);

	input	  areset;
	input	  inclk0;
	output	  c0;
`ifndef ALTERA_RESERVED_QIS

`endif
	tri0	  areset;
`ifndef ALTERA_RESERVED_QIS

`endif

	wire [0:0] sub_wire2 = 1'h0;
	wire [4:0] sub_wire3;
	wire  sub_wire0 = inclk0;
	wire [1:0] sub_wire1 = {sub_wire2, sub_wire0};
	wire [0:0] sub_wire4 = sub_wire3[0:0];
	wire  c0 = sub_wire4;

	altpll	altpll_component (
				.areset (areset),
				.inclk (sub_wire1),
				.clk (sub_wire3),
				.activeclock (),
				.clkbad (),
				.clkena ({6{1'b1}}),
				.clkloss (),
				.clkswitch (1'b0),
				.configupdate (1'b0),
				.enable0 (),
				.enable1 (),
				.extclk (),
				.extclkena ({4{1'b1}}),
				.fbin (1'b1),
				.fbmimicbidir (),
				.fbout (),
				.fref (),
				.icdrclk (),
				.locked (),
				.pfdena (1'b1),
				.phasecounterselect ({4{1'b1}}),
				.phasedone (),
				.phasestep (1'b1),
				.phaseupdown (1'b1),
				.pllena (1'b1),
				.scanaclr (1'b0),
				.scanclk (1'b0),
				.scanclkena (1'b1),
				.scandata (1'b0),
				.scandataout (),
				.scandone (),
				.scanread (1'b0),
				.scanwrite (1'b0),
				.sclkout0 (),
				.sclkout1 (),
				.vcooverrange (),
				.vcounderrange ());
	defparam
		altpll_component.bandwidth_type = "AUTO",
		altpll_component.clk0_divide_by = 25,
		altpll_component.clk0_duty_cycle = 50,
		altpll_component.clk0_multiply_by = 54,
		altpll_component.clk0_phase_shift = "0",
		altpll_component.compensate_clock = "CLK0",
		altpll_component.inclk0_input_frequency = 20000,
		altpll_component.intended_device_family = "Cyclone IV E",
		altpll_component.lpm_hint = "CBX_MODULE_PREFIX=VGAFrequency",
		altpll_component.lpm_type = "altpll",
		altpll_component.operation_mode = "NORMAL",
		altpll_component.pll_type = "AUTO",
		altpll_component.port_activeclock = "PORT_UNUSED",
		altpll_component.port_areset = "PORT_USED",
		altpll_component.port_clkbad0 = "PORT_UNUSED",
		altpll_component.port_clkbad1 = "PORT_UNUSED",
		altpll_component.port_clkloss = "PORT_UNUSED",
		altpll_component.port_clkswitch = "PORT_UNUSED",
		altpll_component.port_configupdate = "PORT_UNUSED",
		altpll_component.port_fbin = "PORT_UNUSED",
		altpll_component.port_inclk0 = "PORT_USED",
		altpll_component.port_inclk1 = "PORT_UNUSED",
		altpll_component.port_locked = "PORT_UNUSED",
		altpll_component.port_pfdena = "PORT_UNUSED",
		altpll_component.port_phasecounterselect = "PORT_UNUSED",
		altpll_component.port_phasedone = "PORT_UNUSED",
		altpll_component.port_phasestep = "PORT_UNUSED",
		altpll_component.port_phaseupdown = "PORT_UNUSED",
		altpll_component.port_pllena = "PORT_UNUSED",
		altpll_component.port_scanaclr = "PORT_UNUSED",
		altpll_component.port_scanclk = "PORT_UNUSED",
		altpll_component.port_scanclkena = "PORT_UNUSED",
		altpll_component.port_scandata = "PORT_UNUSED",
		altpll_component.port_scandataout = "PORT_UNUSED",
		altpll_component.port_scandone = "PORT_UNUSED",
		altpll_component.port_scanread = "PORT_UNUSED",
		altpll_component.port_scanwrite = "PORT_UNUSED",
		altpll_component.port_clk0 = "PORT_USED",
		altpll_component.port_clk1 = "PORT_UNUSED",
		altpll_component.port_clk2 = "PORT_UNUSED",
		altpll_component.port_clk3 = "PORT_UNUSED",
		altpll_component.port_clk4 = "PORT_UNUSED",
		altpll_component.port_clk5 = "PORT_UNUSED",
		altpll_component.port_clkena0 = "PORT_UNUSED",
		altpll_component.port_clkena1 = "PORT_UNUSED",
		altpll_component.port_clkena2 = "PORT_UNUSED",
		altpll_component.port_clkena3 = "PORT_UNUSED",
		altpll_component.port_clkena4 = "PORT_UNUSED",
		altpll_component.port_clkena5 = "PORT_UNUSED",
		altpll_component.port_extclk0 = "PORT_UNUSED",
		altpll_component.port_extclk1 = "PORT_UNUSED",
		altpll_component.port_extclk2 = "PORT_UNUSED",
		altpll_component.port_extclk3 = "PORT_UNUSED",
		altpll_component.width_clock = 5;
endmodule
