From: "dominique.deloison@laposte.net" <dominique.deloison@laposte.net>
Subject: (unknown)
Date: Wed, 24 Sep 2008 18:36:29 +0200 (CEST)
Message-ID: <25523840.1496811222274189329.JavaMail.www@wwinf8203>
Reply-To: "dominique.deloison@laposte.net" <dominique.deloison@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out2.laposte.net ([193.251.214.119]:62903 "EHLO
	out1.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754657AbYIXQga convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Sep 2008 12:36:30 -0400
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8204.laposte.net (SMTP Server) with ESMTP id 616F07000089
	for <linux-input@vger.kernel.org>; Wed, 24 Sep 2008 18:36:29 +0200 (CEST)
Received: from wwinf8203 (lbao93aubmepnpf001-182-pip.meplus.info [10.98.49.10])
	by mwinf8204.laposte.net (SMTP Server) with ESMTP id 53C257000085
	for <linux-input@vger.kernel.org>; Wed, 24 Sep 2008 18:36:29 +0200 (CEST)
Subject: 
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


Hi,=20

=20
I have been trying to enable force feedback with my MS SideWinder FF2 f=
or a while. My Linux system is a Xubuntu 8.04 (kernel 2.26) After a lot=
 of problems, I have made some progress. First I figured out I had to r=
ecompile the kernel with options to activate the force feedback support=
 (PID Force feedback). Sorry, I suppose it was obvious for you.

Then I tested my Sidewinder with ff-utils and geforce-0.3. I could get =
pretty convincing force effects but only once: after the 1st effect is =
finished, if I ask for another one, the system freezes and I have to re=
boot. This is a reproducible process.

I do not know whether I made some mistake during the compilation of the=
 kernell (I have no sound and no wifi with this kernel) or if this is a=
 normal behaviour considering that the Sidewinder FF2 support is experi=
mental. I think it is not far from working since the force effects seem=
 good to me

I have another computer with Vista and I installed fedit (to generate f=
orce feedback effects) and SniffUsb 2.0 to monitor the USB communicatio=
ns between the joystick and the computer. Maybe this could help someone=
 using my logs to improve the current driver?

=20

Many thanks

 Cr=C3=A9ez votre adresse =C3=A9lectronique prenom.nom@laposte.net=20
 1 Go d'espace de stockage, anti-spam et anti-virus int=C3=A9gr=C3=A9s.


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
