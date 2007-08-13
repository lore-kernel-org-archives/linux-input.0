From: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] SERIO: Fix modpost warning.
Date: Mon, 13 Aug 2007 13:05:50 +0100
Message-ID: <20070813120550.GA27033@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Andrew Morton <akpm@linux-foundation.org>, dtor@mail.ru, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

i8042_unregister_ports's only caller i8042_remove is a __devexit function
so make it __devexit too.

  Ralf

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 3888dc3..ed286aa 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -1038,7 +1038,7 @@ static void __devinit i8042_register_ports(void)
 	}
 }
 
-static void __devinit i8042_unregister_ports(void)
+static void __devexit i8042_unregister_ports(void)
 {
 	int i;
 
