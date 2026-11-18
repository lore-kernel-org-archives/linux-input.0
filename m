Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.2.64.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014028;
	b=uBaLkl3dkmmc8A4G5cChpbMeR3KAoR/LJ5r1XFDw0cYvgDs6rbTXcU1raZ3WsoMhPVx8
	 i+d8C8hUCkUBPO1EHHzbVj55TIGwzBttCesiGyJ9iUmwcvvH48NKHOwuYEecTX+3pzTN0
	 MCjOSjTnpFTDHjivhlbXA18OFTYCFkTVq+vNgSbq4YyJ6NoAcZJvujGcNFOBKZ4H9EBzN
	 7Mh/SYXD9Rg1n94H91NJOt7gbEqt6H6bZhDwb+0f/Xxl6nK8LGWVDy+i++R5EGbtgdeof
	 m/6E9qg7fIYFuGZ7oDSxNo6QPGNvhxDM4Df4fFh9mj2JpSuBPSbEWy9N4uVun+6hKtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014028;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:Date:
	 Message-ID:X-Mailer;
	bh=xIqP9DW0MNb8cbUSMB4qwOLD6IctYX6wVFr0Jt4lshg=;
	b=gga4T7aARx+nwzeFy1ogqIN5qULERtWCJWho/7Vkkpkk45GK+2lhdFxmY4RGBZOmiaAb
	 XKf76Ln+IR+ND1x4opWIg/vpuZPyz8f9q26CikJVjhyKQCKUAMWTBU7lR7ucDm5NjteEH
	 GTBNNonWuDlu4rzy0gM/rndRGaCX6bkmpJQ+Tfy2AKE7vqtb+bJt0oGQhbqB2xPV2kQHm
	 MI2xFt8WAcUazFyDqT/2GZtwWIOH3zhqyS6WCuefwxLi79hrwcl4XXppFzJIM2vTjr415
	 b7pG10GShVBOzEUvvPmQHdO+9Tiv+IZB4rU4RemDHN3UXSvJwESsWJC9H9cS5/CAucg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=EwfrE1wC;
	arc=none smtp.remote-ip=34.2.64.18
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com [34.2.64.18])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0AE606A325
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 15:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB0AE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=EwfrE1wC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1795014026; bh=xIqP9DW0MNb8cbUSMB4qwOLD6IctYX6wVFr0Jt4lshg=; h=From:To:Cc:Subject:In-Reply-To:References:Content-Type:Date:From:Subject:Reply-To:Content-Type; b=EwfrE1wCkMIAcRR52/xuNkW0E0Ov6fHUpOiyxLAC/lctf1qGNJAW2luqgTHKGLlftnB2fhdAze4QhaOAQn5tfjkruKWER9trRMmf/BqGUnD+u4dz2tcJP04CbCD3YaOzojlNeCj9DumqtkeGQytfQ4Py/LLTNoZS0C5m/o5hsiQkim4DAJ5t7HoZQ8q93BloJ/yTobH6e+GZQWs4tCsHCYAzs3QuwU8nmdzxySYTLqe0GXtuy1WrYZsVrZEE9FKDYpIpPpciNRvd4CmiycFWUh71gdGe/Q7sXO4ts5G7T3RN6yIhd8PSNo/HtTl+1tnd4Osljb5HKE9jVmeHL8o4eg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1795014026; bh=RCiGym3CU8r0C6LVzkksbr0t+PRx3iPkDnpOh/F0JH/=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=IlTqul6xKUFAiLZIi4rLoN6m92Gkkwke1N3kthHmAfbx2DPRmmVgc2Aq0FhgqRf8WmzbwqCvglXsHsYQXznpE3Y8RBsOdyFm0vFSoEYrLIFf5i3gpkYusUulcJRe1KnHLNz9Jg4jE8B6uay1otHYXze3caLZDk3vtd/XUTnVPGO+yALIDW3pKlwXfghzDAB9YPlwz8k2Bpq/N+RCCUjZK+e6WGZ+KY9bBE121UeYj3f45ecarKFD14H+e8iAzZkNmoJxAdrovjOwT8f0b8VND45uIvigmS4qHAsz1ABsMJb3tRyegYGb2+jsLFn4zYbxVulyeC7OsmrZol+NBTw+Xw==
X-YMail-OSG: zaODDQ8VM1m9mxg_ufJDXxMzGJbO2SaJab0zLytJvodbZTOCEywBLhb9WAbpj3d
 b2LrtS9VpZAWpHGf89y78SzazHRDGJWLya45YxJWLM34WoJR03KBoKiGG3fKxUpLfda3E5YimCs6
 AYal_2A4fUh8OXB5zgZM_YEsJMHAKhJY4DEKEuqHbdPBIbwH.dW_mo42dumYV6SK21JqHiCRntIj
 GJtFf1qFLXF6BuHpksgB9MJheAi2MYSu2S8lRID5yKz8SUd4vcMDm6zzEhOX41yCOyZu8iJOvvgQ
 .SqV60DDDFT7MqkGHHGenfRGGWV33uZDptIN8BfhbAZiD6NNMbKEn.SXZI4LXvz4HcETexf_F6EF
 yLp589K9KziCyi7CZ_bEJhXnjroAt7Ix4xBbE.Da1WiwtPUD9s0GwHScdry4kXIT88NmMhZ6nsEt
 eoGCdC1nkNa6UeJnqtW9T2jnsAyDsclJNX0WAPwjWHn5ovNYBXqk0fvtelKXaV2R0s64grL2L6qe
 73Vja.OlgInt6OexGTGN7sjG9TRiJw5FnbQIVgnAjOyiPbMEsWKSAMqZf2Bk._SV8XKkCgaw883D
 7t65GCWnBp0D03j2aYaJr7a.dfGgK0SeV0ifUaqW8KdFG79dEKfm9S0bC3grxpN2y5JWDC0nWYfm
 VQC7T_3Gw9HBfgLnjVTSkTgN.PlO7Zcfix4242ouynu4tw2KJ_79S9ju.F2AjpbSP5FAPzwqDgcE
 8Kdd59VRj_P3HCf9B2TxGCn10nqViKbSTBZbYNtUW1zu4df7L9Roz6feZ5iQpr5xirc87vdmBQ94
 5o_zeLV.4rBLTDJk1d_zMQ2PdkUrfBCGg5F1E.qoRRbZ5CCoRy0fNrqhjF9Tebt0lPtUaNc._dNn
 2WBF3_0dbBuz18dCCvNzf0K0Imj.AHPhkHKZeZl2HslEk_7cf_EckNgJKlnqKTahxedpAt8kuBPX
 INTIJXjIUOGUUmpyDD8d86GnfTHeGI87jNM3gIyxc46XXfx7S5Yw78djbUD_cyGWmZAd0mIssH4d
 LLlPJUzDByc3OkTzIk4jAc0bfIZ2lRzeGxKEwiVIXnUdbxuUp3v9smxKBwX5qrja0WgB4EaIlYkH
 qN0TwEfCuJjxlzAaJ8yG8xB70bZHMlyj.erX6xMy3wd.oV8UcJMx7pja3D.h740PnpvaBlmj7beT
 Po8QmZSkEefjRjxq8ttHsviw_5zJbMBL7eV2O70QJ6TxXydrUmihQ5T8S0Hru97rbEuuRS_EfN4j
 1hgHEe5VJ8O6YuYeMBg.W67BvWySaJr08FKkG2LyC2V_8Z4WKCBFbEIITeoDh08uY8mLGyofOmu8
 dEtCHVxCMA6tI.V9Sfi13p7OoPMsQZUOT5XgnvPNUQAhbVWwbT8TPCJZZv8yYE8kgkWRERaPol8F
 gZ3763n4Baydyp7AyCO2N_qWmdQ2LuaWS5_71SdJf3LI7DJZdcHDByMkLL9gkd9p_pI_SIATcyL.
 QSEI9agH.hnndAd0RGKins9y0zIryqxqBEstsQUSlN2buss5V2..R.j5tKaArc_MZb7C3WGOBD0_
 QBjUUVZgOxBNi2EOwtZu9CQcq58nipN7RlcRi6HxCWoP33wbDHvJiulcRlo9noXj51YvphrpS9xn
 p.eoCbOhz87rsxBzggTzO31YCCToT3ZhBvxwEyGcwJQ09tjSAYCcIvo02dNpzqMrJRZmobkQOHc5
 a1Kgok3COxRF6EeaMqzdXEK9MHNYfFwXY0r3iRxl0NXZk2aioJiECEBYXCLXx2TdVJBr1TccKZJp
 MzSSy3pJwGvG4GEghvQ3OSPntal3QPppTEMgJXzBTLiQ.lWHsc1yEIr8yqDlLAl9AT5Rmjhqe83n
 56IBv9Z7rxd.ku1E9j5Qi63Pye2kWlmUEWTrYYPYyEo7I_JCpxRwQdy9lGUcQDDutYpfIqNtehsA
 OQJQGVt93dQdhk5PiCdSAvYs5Cq656SZle73ZztDQYk1bd1iKsUUHVLNG1qrrw0Gc5d1quTBrJq7
 yf6ZLgcVN_wGB
X-Sonic-MF: <capitain_jack@yahoo.com>
X-Sonic-ID: b63a302d-7415-4630-ad1f-8e1de52c2318
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-102 with HTTP; Wed, 18 Nov 2026 15:00:26 +0000
Received: from dip20.lsn.bf1.yahoo.com ([67.195.177.29])
          by hello (SMTP) with SMTP ID 18b76bb473d01ac89d7404256b7eb674;
          Wed, 18 Nov 2026 15:00:20 +0000 (UTC)
From: Daniel Campos Ramos <capitain_jack@yahoo.com>
To: Tomasz =?utf-8?q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
Cc: dmitry.torokhov@gmail.com, corbet@lwn.net, jikos@kernel.org,
 bentiss@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, vi@endrift.com, linux-kernel@altimeter.info,
 peter.hutterer@who-t.net, Ricardo Esteves <ricardo.lopes.esteves@oracle.com>
Subject: Re: [RFC PATCH 0/6] Input: New EV_BTN event for generic buttons
In-Reply-To: <20260104213132.163904-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260104213132.163904-1-tomasz.pakula.oficjalny@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 18 Nov 2026 12:00:15 -0300
Message-ID: <179501401503.113617.9596561330028866042@yahoo.com>
X-Mailer: WebService/1.1.27017 mail.core.serving.mcws.prd.acl:role.token.mcws.jsmtp.yahoo

Hi Tomasz,

Your EV_BTN series has a home. I carry the six patches as posted in
the kernel of Sparky Stereo OS, my edition of SparkyLinux, in all
three flavours we build (normal, x86-64-v3 and PREEMPT_RT), on 7.3.4.
Your SDL pull request 14758 and your Wine merge request 9853 are in
our SDL and Wine packages beside it.

Thank you for this work. Thanks also to Ivan Gorinov and Ricardo
Esteves, whose patches of December and February went at the same
limit from the other side.

Why I wanted it: more than 80 buttons is ordinary hardware now. Sim
racing and flight cockpits, button boxes, control surfaces and
accessibility devices built from many switches all pass that number.
Linux can be the platform for these, and today it stops at button 80.

What I measured, with a virtual HID joystick (uhid) of 128 buttons,
eight hats and twelve axes:

  With the series:
    EVIOCGBTNCNT gives 128.
    All 128 buttons arrive as EV_BTN, the first 80 also as EV_KEY.
    SDL3 with pull request 14758 reads 128 buttons, and so do SDL2
    programs through sdl2-compat.
    Wine with merge request 9853 gives DirectInput 128 buttons, by
    the udev backend and by the SDL bus.
  Without the series:
    80 buttons as EV_KEY, and SDL reads 79.

Two notes on those results. The SDL number is with one small fix on
top of the pull request: built against kernel headers that have no
EV_BTN, its fallback define never asks the kernel, and SDL stays at
79 buttons. The Wine number needed two small fixes in Wine itself,
outside your merge request. Both belong to those projects and not to
this thread.

One thing for a next version. A report that changes many buttons at
once overflows the evdev client buffer. With all 128 buttons changing
in one report the client received 44 of the 128 EV_BTN events and a
SYN_DROPPED. input_estimate_events_per_packet() makes room for "KEY
and MSC events" with a constant 7 and does not count EV_BTN. Counting
one event per button when the device has EV_BTN gives 128 of 128 and
no SYN_DROPPED here:

 	/* Make room for KEY and MSC events */
 	events += 7;
 
+	/* Every generic button can change in one report */
+	if (test_bit(EV_BTN, dev->evbit))
+		events += dev->button_count;
+
 	return events;

It only makes sense on top of your patch 2, so take it into the
series if it is useful.

Benjamin's review of patches 3 and 4 reads to me as the way to a
next version. The test device's descriptor and the result tables are
available to anyone who wants them.

I work with AI partners on this distribution. I read and ran what is
reported here and I answer for it.

Daniel Campos Ramos
Sparky Stereo OS
https://github.com/Sparky-OS/sparky-stereo-os
