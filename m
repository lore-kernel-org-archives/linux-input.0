From: "Takeuchi, Toshiki" <toshiki.takeuchi@wacom.com>
Subject: Demand for hid_input.c's process
Date: Mon, 11 Sep 2017 03:06:13 +0000
Message-ID: <DB6PR0701MB25351C528313F0F9303BD4178B680@DB6PR0701MB2535.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-eopbgr40058.outbound.protection.outlook.com ([40.107.4.58]:3679
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752070AbdIKDGR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 10 Sep 2017 23:06:17 -0400
Content-Language: ja-JP
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dear Sir or Madam

I'm facing a problem because of the implementation in "hid_input.c".
The function, =1B$B!H=1B(Bhidinput_configure_usage()=1B$B!I=1B(B handles ma=
ny usage.
However, usage=3D0x45(Eraser) is not supported on usage-page =1B$B!H=1B(BHI=
D_UP_DIGITIZER=1B$B!I=1B(B.
So, this function add key =1B$B!H=1B(BBTN_MISC=1B$B!I=1B(B to map (because =
unknown usage) then.
I=1B$B!G=1B(Bd like to add the key which is endemic to eraser like =1B$B!H=
=1B(BBTN_ERASER=1B$B!I=1B(B.
Could you please add the process to =1B$B!H=1B(Bhidinput_configure_usage()=
=1B$B!I=1B(B?
Or, if you can=1B$B!G=1B(Bt, could you please permit me to fix the process?

Thank you,
Best Regards,
Takeuchi.

------------------------------------------
=1B$BC]Fb=1B(B =1B$B=3DS5.=1B(B(Takeuchi Toshiki)

=1B$B")=1B(B160-6135
=1B$BEl5~ET?7=3DI6h@>?7=3DI=1B(B8=1B$BCzL\=1B(B17=1B$BHV=1B(B1=1B$B9f=1B(B
=1B$B=3D;M'ITF0;:?7=3DI%0%i%s%I%?%o!<=1B(B35=1B$B3,=1B(B
Email:takeuchi.toshiki@wacom.co.jp
Tel:+81-80-9989-9873
------------------------------------------

