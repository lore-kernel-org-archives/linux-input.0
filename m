From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH 0/4] E6 bug fix and code cleanup
Date: Tue, 26 Jun 2012 14:46:05 -0400
Message-ID: <4FEA036D.2050107@seas.upenn.edu>
References: <1340660124-27323-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from talbot.seas.upenn.edu ([158.130.67.217]:56512 "EHLO
	talbot.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757918Ab2FZSxA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jun 2012 14:53:00 -0400
In-Reply-To: <1340660124-27323-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/25/12 17:35, Ping Cheng wrote:
> The first two patches fix 0xE6 bug. The other two are just cleanup.
> 
> Ping Cheng (4): input - wacom: fix retrieving touch_max bug input - wacom:
> don't retrieve touch_max when it is predefined input - wacom:
> BTN_TOOL_DOUBLETAP is not a valid device_type input - wacom: TPC2FG doesn't
> store touch id for slots
> 
> drivers/input/tablet/wacom_sys.c |    8 +++++--- 
> drivers/input/tablet/wacom_wac.c |    6 ++++-- 2 files changed, 9
> insertions(+), 5 deletions(-)
> 

Tested-by: Rafi Rubin <rafi@seas.upenn.edu>

Applying this set of patches reverted a "dead-digitizer" regression for me.
Tested with an E6 digitizer.

Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJP6gNqAAoJEPILXytRLnK2HBkQAKULqtywJeDxtbvFpRBMnQy2
wM6zQ9yH4ofLxxuzuKj998jSU1yDb/5Nj7pWk9V0rxfvc9NF2MsypUpADYCmMabA
CvTt1/Sgu+tanetE9t8VshvRLHCV0tpffF8s1UHyjZ8gSMzwm92b/hL8SB1KP/KC
xrJmaYV1Kmcnr53uaBaZqCWv8wJlhK3NVa8A5izyx2UQKBYYmpBcHoUtjIDbSo0o
sfMbmOtyW86HBXTcP+BZqID2Pp9uYDpx5EaPMdfRJpFScLW317xe8QRXFwKI8XOj
J0LGquf8RaVvVL9HiVboYQiF/bhSo5ofWyNyhTXwJlTtSLnz8EvhdrT1SIBtuvwf
Yuv4x5xhGBhTiJK7xixNtlE9zCGH61Fd7uhfHjlPqxU5VA8R23FxvBy9X0dd2YkZ
1yNkhCNaZlcSK212Gjzisl+FCogNQOpjm5Jg/VMIpkXVuETZJJDBihTcmApFe7pk
gDVT0ZG2AYBVoDa8jYRnEw9cdr5+rltV3OC2BIVjVPVfela66xZkTe7ezEgjDZsr
pAUS/35uXY9qXk9L5f/AAOtunhJiD/5Va2CiIf/4k4DlxYHi2rvgM3E5n62Usvcx
OHeh+HXZ6w58EqrMpxMIPC8BG5ZLx2z5y5UHviha+bZNtgc8UzbRNq3IDL0udG7M
reef64N293NTIXdSXCvk
=7Xpa
-----END PGP SIGNATURE-----
