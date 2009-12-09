From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: Please pull bjdooks' git tree
Date: Wed, 9 Dec 2009 21:29:16 +0000
Message-ID: <20091209212916.GA20296@fluff.org.uk>
References: <E1NI9YG-0003dB-54@teyla.home.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:53713 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750926AbZLIV3g (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Dec 2009 16:29:36 -0500
Content-Disposition: inline
In-Reply-To: <E1NI9YG-0003dB-54@teyla.home.fluff.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, linux-input@vger.kernel.org, dimitry.torokhov@gmail.com

On Tue, Dec 08, 2009 at 11:33:04PM +0000, Ben Dooks wrote:
> The following changes since commit 6035ccd8e9e40bb654fbfdef325902ab53=
1679a5:
>   Linus Torvalds (1):
>         Merge branch 'for-2.6.33' of git://git.kernel.dk/linux-2.6-bl=
ock

If it is not too late, then please replace this with the following
pull request, which missed out a patch needed to define the necessary
platform data and device definitions for the touchscreen driver.

The following changes since commit 6035ccd8e9e40bb654fbfdef325902ab5316=
79a5:
  Linus Torvalds (1):
        Merge branch 'for-2.6.33' of git://git.kernel.dk/linux-2.6-bloc=
k

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git s3c24xx-updates2

Arnaud Patard (1):
      ARM: S3C24XX: touchscreen device definition

Ben Dooks (1):
      ARM: S3C24XX: Export s3c24xx_set_fiq for modules.

Ramax Lo (1):
      ARM: S3C24XX: DMA: Use valid index when accessing array

Uwe Kleine-K=C3=B6nig (2):
      ARM: S3C: move s3c_adc_remove to .devexit.text
      ARM: S3C: move s3c_pwm_remove to .devexit.text

 arch/arm/mach-s3c2410/include/mach/ts.h |   21 +++++++++++++++++++++
 arch/arm/plat-s3c/include/plat/devs.h   |    1 +
 arch/arm/plat-s3c/pwm.c                 |    2 +-
 arch/arm/plat-s3c24xx/adc.c             |    2 +-
 arch/arm/plat-s3c24xx/devs.c            |   18 ++++++++++++++++++
 arch/arm/plat-s3c24xx/dma.c             |    6 ++++--
 arch/arm/plat-s3c24xx/irq.c             |    2 ++
 arch/arm/plat-s3c24xx/s3c244x.c         |    1 +
 8 files changed, 49 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-s3c2410/include/mach/ts.h


--=20
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
