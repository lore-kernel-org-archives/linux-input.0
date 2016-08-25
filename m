From: Ville Ranki <ville.ranki@iki.fi>
Subject: Re: [PATCH] Input: joydev - Recognize joysticks with Z axis as
 joysticks.
Date: Thu, 25 Aug 2016 23:56:22 +0300
Message-ID: <e0aece92-b147-4c7d-90a9-c0243a224b01@iki.fi>
References: <1472134610-6438-1-git-send-email-ville.ranki@iki.fi>
 <20160825164530.GD11206@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.cs.tut.fi ([130.230.4.42]:37110 "HELO mail.cs.tut.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756565AbcHYWxW (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 Aug 2016 18:53:22 -0400
In-Reply-To: <20160825164530.GD11206@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/25/2016 07:45 PM, Dmitry Torokhov wrote:
>> This patch adds ABS_Z to the input_device_id list allowing
>> devices with ABS_Z axis to be detected correctly.
> 
> I am curious why you still use joydev and not switch your client(s)
> to evdev? Or is it some legacy game?

Yes, this is about legacy games. For example X-Plane requires
joystick node to be present.

- -- 
Ville Ranki <ville.ranki@iki.fi>
http://www.iki.fi/~cos
PGP public key: http://www.iki.fi/~cos/vranki_pub.asc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAle/W3UACgkQVm11nqR7UVwysgCcDb9WIsMKC9qNPHxMWA9rFSqM
7YcAnibn2E02M4/7v7QjD0wuD3QdJMhG
=DjXV
-----END PGP SIGNATURE-----
