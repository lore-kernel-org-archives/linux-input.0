From: Chr <chunkeey@web.de>
Subject: Re: [PATCH] usbhid: add ASUS LCM to the blacklist
Date: Fri, 12 Oct 2007 10:49:33 +0200
Message-ID: <200710121049.34149.chunkeey@web.de>
References: <200707240228.39421.chunkeey@web.de>
	<8a1758740710101811q22fc235aifb1edcccd6e98e56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <8a1758740710101811q22fc235aifb1edcccd6e98e56@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Javier =?iso-8859-15?q?Bola=F1os?= Molina <javinovich@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

On Thursday, 11. October 2007, Javier Bola=F1os Molina wrote:
> Hi all,
> [...]
> Well I installed this patch, recompiled my kernel and tried again asusoled
> application in order to test the oled display.
> First time everything seemed as usual as it was with a standard (no patch=
ed)
> kernel, asusolded ask me to rmmod  usbhid as it was not able to get contr=
ol
> on the oled.
> Then I removed the usbhid and tried again, it worked. Nothing new.
> After this I loaded usbhid in order to use my mouse.
> then I tried asusoled  and  fortunately this time it worked  this time wi=
th
> usbhid loaded.
> =

> To sum up the patch works fine once I remove and load usbhid once. I tend=
 to
> think this could be a bootstrap bug as it does work well after a manual
> reload of usbhid.
> =


hmm, sounds like the old usbhid module is still around... =

My first guess: Do you use a initrd? Have you updated it, after you recompi=
led your kernel?

> [...]
> PS.
> I don't know  German so it was difficult to understand the page in
> https://zockertown.de/s9y/archives/882-asusoled-compilieren.html so I wou=
ld
> suggest to update https://launchpad.net/asusoled/ maybe I could help.
> =

> Regards,
> Javier Bola=F1os Molina.
> =


The project moved to sourceforge.net. The new maintainer is:

Adilson Oliveira <adilson@linuxembarcado.com.br>

Thanks,
	Chr.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
