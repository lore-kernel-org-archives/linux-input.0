From: Jim Paris <jim@jtan.com>
Subject: Re: [PATCH v2 0/3] Another try for the Sixaxis plugin
Date: Fri, 25 Mar 2011 11:31:05 -0400
Message-ID: <20110325153105.GA26039@psychosis.jim.sh>
References: <1298628292-8842-1-git-send-email-ospite@studenti.unina.it>
 <1298637244.10364.19.camel@novo.hadess.net>
 <20110324183247.3291e59e.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from jim.sh ([75.150.123.25]:60515 "EHLO psychosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922Ab1CYPhU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Mar 2011 11:37:20 -0400
Content-Disposition: inline
In-Reply-To: <20110324183247.3291e59e.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org, linux-input@vger.kernel.org, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>, Mikko Virkkila <virkkila@kapsi.fi>

Antonio Ospite wrote:
> With regard to that, I'd like to see some USB dumps of a Sixaxis
> talking with GameOS to check if the PS3 can turn off BT on the
> controller explicitly, can anyone help here? (Pascal? Do you have
> access to a USB analyzer?):
> 
> The scenarios I am interested in are:
>  1. Connect a non-paired Sixaxis to the PS3 via USB
>  2. Connect an already paired Sixaxis to the PS3 via USB
>  3. Connect a Sixaxis already associated via BT to a PS3 via USB

Hi Antonio,

You asked me for this a while ago, sorry it took so long.  I ran some
tests and put the log files here:
  http://ps3.jim.sh/sixaxis/dumps/

There are comments in the file:

$ grep Comment sixaxis-pairing-tests-abbreviated.csv 
0,,2,0:03.145.728,,,,,,Comment,,"1. Controller is a DS3 model CECHZC2U, bdaddr 00:24:33:E6:2C:3C"
0,,3,0:04.893.354,,,,,,Comment,,"2. PS3-1 is on and has bdaddr 00:13:a9:74:fe:57"
0,,4,0:05.592.405,,,,,,Comment,,"3. PS3-2 is on and has bdaddr 00:23:06:52:e4:e3"
0,,5,0:05.941.930,,,,,,Comment,,"4. Controller previously paired with 00:11:22:33:44:55"
0,,6,0:06.640.981,,,,,,Comment,,"5. Controller powered off with rear button"
0,,7,0:08.738.133,,,,,,Comment,,"6. About to plug controller into PS3-1 (off, wrong pairing)"
0,,285,0:16.314.138,,,,,,Comment,,"7. About to press PS button"
0,,914,0:20.841.170,,,,,,Comment,,"8. Unplugged controller"
0,,915,0:34.123.132,,,,,,Comment,,"9. Controller is now associated with PS3-1"
0,,916,0:41.113.639,,,,,,Comment,,"10. Controller powered off with rear button"
0,,917,0:41.113.639,,,,,,Comment,,"11. About to plug controller into PS3-1 (off, correct pairing)"
0,,1193,1:01.075.280,,,,,,Comment,,"12. Unplugged controller"
0,,1194,1:11.211.515,,,,,,Comment,,"13. Pressed PS button"
0,,1195,1:27.639.205,,,,,,Comment,,"14. Controller is now associated with PS3-1"
0,,1196,1:27.639.205,,,,,,Comment,,"15. About to plug controller into PS3-1 (associated with this PS3)"
0,,2311,1:41.665.351,,,,,,Comment,,"16. Unplugged controller"
0,,2312,1:44.112.029,,,,,,Comment,,"17. Paired and associated controller with PS3-2"
0,,2313,1:57.393.991,,,,,,Comment,,"18. About to plug controller into PS3-1 (associated with different PS3)"
0,,4585,2:26.172.515,,,,,,Comment,,"19. Unplugged controller"

> > The PS3 add-on keyboard, and the PS3 headset both use cable pairing. I
> > have them around, but was unable to get them to pair.
> 
> I don't have the hardware so I never searched to see what the
> differences with the Sixaxis are.

I also did some quick captures of pairing the keypad (CECHZK1UC) and
original headset (CECHYA-0075).  They are being paired with 00:13:a9:74:fe:57.
  http://ps3.jim.sh/sixaxis/dumps/

-jim
