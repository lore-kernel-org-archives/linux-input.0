From: Miltiadis Margaronis <mmargaron@gmail.com>
Subject: [PATCH] input: make 2 macros in gameport.c TSC-aware
Date: Mon, 11 Jun 2007 07:12:32 +0300 (EEST)
Message-ID: <alpine.BSF.0.99.0706110624150.5014@micmac.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii; format=flowed
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org


  This makes DELTA and GET_TIME in drivers/input/gameport/gameport.c
  similar to the ones in drivers/input/joystick/analog.c . Worked on
  2.6.22-rc4-git2.

Signed-off-by: Miltiadis Margaronis <mmargaron@gmail.com>


--- a/drivers/input/gameport/gameport.c	2007-06-05 03:57:02.000000000 +0300
+++ b/drivers/input/gameport/gameport.c	2007-06-09 07:20:45.000000000 +0300
@@ -64,8 +64,8 @@ static void gameport_disconnect_port(str

  #include <asm/i8253.h>

-#define DELTA(x,y)      ((y)-(x)+((y)<(x)?1193182/HZ:0))
-#define GET_TIME(x)     do { x = get_time_pit(); } while (0)
+#define DELTA(x,y)      (cpu_has_tsc ? ((y) - (x)) : ((y) - (x) +((y) < (x) ? CLOCK_TICK_RATE / HZ : 0)))
+#define GET_TIME(x)     do { if (cpu_has_tsc) rdtscl(x); else x = get_time_pit(); } while (0)

  static unsigned int get_time_pit(void)
  {

-- 
Miltos
