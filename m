From: Marcin =?utf-8?Q?=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Subject: [PATCH] keyboard.c: reformat x86_keycodes array initialization
Date: Sat, 1 Dec 2007 22:42:11 +0100
Message-ID: <20071201214208.GB10179@joi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:7727 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbXLAVkw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 1 Dec 2007 16:40:52 -0500
Received: by mu-out-0910.google.com with SMTP id i10so131095mue
        for <linux-input@vger.kernel.org>; Sat, 01 Dec 2007 13:40:48 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

keyboard.c: reformat x86_keycodes array initialization

reformat array initialization to make it fit in 80 characters
with spaces after commas

Signed-off-by: Marcin =C5=9Alusarz <marcin.slusarz@gmail.com>

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index e473b56..97f790f 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -1046,21 +1046,36 @@ DECLARE_TASKLET_DISABLED(keyboard_tasklet, kbd_=
bh, 0);
 		     ((dev)->id.product =3D=3D 0x0001))

 static const unsigned short x86_keycodes[256] =3D
-	{ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
-	 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
-	 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
-	 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
-	 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
-	 80, 81, 82, 83, 84,118, 86, 87, 88,115,120,119,121,112,123, 92,
-	284,285,309,  0,312, 91,327,328,329,331,333,335,336,337,338,339,
-	367,288,302,304,350, 89,334,326,267,126,268,269,125,347,348,349,
-	360,261,262,263,268,376,100,101,321,316,373,286,289,102,351,355,
-	103,104,105,275,287,279,258,106,274,107,294,364,358,363,362,361,
-	291,108,381,281,290,272,292,305,280, 99,112,257,306,359,113,114,
-	264,117,271,374,379,265,266, 93, 94, 95, 85,259,375,260, 90,116,
-	377,109,111,277,278,282,283,295,296,297,299,300,301,293,303,307,
-	308,310,313,314,315,317,318,319,320,357,322,323,324,325,276,330,
-	332,340,365,342,343,344,345,346,356,270,341,368,369,370,371,372 };
+	{ 0,   1,   2,   3,   4,   5,   6,   7,
+	  8,   9,  10,  11,  12,  13,  14,  15,
+	 16,  17,  18,  19,  20,  21,  22,  23,
+	 24,  25,  26,  27,  28,  29,  30,  31,
+	 32,  33,  34,  35,  36,  37,  38,  39,
+	 40,  41,  42,  43,  44,  45,  46,  47,
+	 48,  49,  50,  51,  52,  53,  54,  55,
+	 56,  57,  58,  59,  60,  61,  62,  63,
+	 64,  65,  66,  67,  68,  69,  70,  71,
+	 72,  73,  74,  75,  76,  77,  78,  79,
+	 80,  81,  82,  83,  84, 118,  86,  87,
+	 88, 115, 120, 119, 121, 112, 123,  92,
+	284, 285, 309,   0, 312,  91, 327, 328,
+	329, 331, 333, 335, 336, 337, 338, 339,
+	367, 288, 302, 304, 350,  89, 334, 326,
+	267, 126, 268, 269, 125, 347, 348, 349,
+	360, 261, 262, 263, 268, 376, 100, 101,
+	321, 316, 373, 286, 289, 102, 351, 355,
+	103, 104, 105, 275, 287, 279, 258, 106,
+	274, 107, 294, 364, 358, 363, 362, 361,
+	291, 108, 381, 281, 290, 272, 292, 305,
+	280,  99, 112, 257, 306, 359, 113, 114,
+	264, 117, 271, 374, 379, 265, 266,  93,
+	 94,  95,  85, 259, 375, 260,  90, 116,
+	377, 109, 111, 277, 278, 282, 283, 295,
+	296, 297, 299, 300, 301, 293, 303, 307,
+	308, 310, 313, 314, 315, 317, 318, 319,
+	320, 357, 322, 323, 324, 325, 276, 330,
+	332, 340, 365, 342, 343, 344, 345, 346,
+	356, 270, 341, 368, 369, 370, 371, 372 };

 #ifdef CONFIG_SPARC
 static int sparc_l1_a_state;
-
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
