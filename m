From: =?koi8-r?Q?=E1=CE=D4=CF=CE_=E5=D2=CF=C6=C5=C5=D7=D3=CB=C9=CA?=
	<aeforeve@mail.ru>
Subject: Multikey autorepetition
Date: Sun, 25 Jul 2010 22:27:28 +0400
Message-ID: <E1Od5v6-0004iL-00.aeforeve-mail-ru@f207.mail.ru>
Reply-To: =?koi8-r?Q?=E1=CE=D4=CF=CE_=E5=D2=CF=C6=C5=C5=D7=D3=CB=C9=CA?=
	  <aeforeve@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fallback4.mail.ru ([94.100.176.42]:50265 "EHLO
	fallback4.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab0GYS14 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Jul 2010 14:27:56 -0400
Received: from f207.mail.ru (f207.mail.ru [217.69.128.146])
	by fallback4.mail.ru (mPOP.Fallback_MX) with ESMTP id B097A2AB31E4
	for <linux-input@vger.kernel.org>; Sun, 25 Jul 2010 22:27:54 +0400 (MSD)
Received: from mail by f207.mail.ru with local
	id 1Od5v6-0004iL-00
	for linux-input@vger.kernel.org; Sun, 25 Jul 2010 22:27:28 +0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

sory for my english

Multikey autorepetition in linux and x-win

Has decided to write for this purpose - that most to understand - wheth=
er is it in linux a defect or and has been conceived

The basic question in that is that if to press 2 keys - why one repeats=
 only?

Will tell I in a spreadsheet I press downwards and to the right - and i=
n general that I expect that the cursor will run on a diagonal - but it=
 =D0=D2=C5=D4 only in one direction

Why? It is a defect or and should be?

I for myself have found in a kernel and in =C9=CB=D3=C1=C8 places that =
for it answer - they strangely enough are almost identical that in a ke=
rnel that in =C9=CB=D3=C1=C8

And the theory is that - if not to concern ps/2 keyboards - that an ess=
ence here in what usb the keyboard sends in a computer of purely event =
of pressing and unpressing keys - and it is 8 byte package - 1 byte a c=
ondition of keys of modifiers - 2 byte a reserve - 3-8 bytes codes of t=
he pressed keys
=46or this reason usb the keyboard theoretically  to serve only 6 simul=
taneous pressing (without modifiers)

here - a car usb the key at all is not engaged in repetition - in syste=
m that in a kernel that in x-win - for autorepetition the usual timer a=
nswers - which joins by key pressing - and through the necessary interv=
als adds pressing
But it is made so - that autorepeat only one key

Here and at me the question is a defect or and should be?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
