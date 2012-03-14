From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH v4 0/4] Wacom Wireless Module Support
Date: Wed, 14 Mar 2012 11:25:38 -0700
Message-ID: <CANRwn3SBOE+KDfT_QSWoUXKdeBrwH1eTwHB57ZUkgWcTmsWsNg@mail.gmail.com>
References: <1331686322-4914-1-git-send-email-chris@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:59093 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab2CNSZj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Mar 2012 14:25:39 -0400
Received: by wibhr17 with SMTP id hr17so6584732wib.1
        for <linux-input@vger.kernel.org>; Wed, 14 Mar 2012 11:25:38 -0700 (PDT)
In-Reply-To: <1331686322-4914-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris@cnpbagwell.com
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Tue, Mar 13, 2012 at 5:51 PM,  <chris@cnpbagwell.com> wrote:
> From: Chris Bagwell <chris@cnpbagwell.com>
>
> The 3rd gen Bamboo Pen & Touch and Intuos5 tablets support an
> optional wireless module. =C2=A0This patch set adds support for it.
>
> New in v4 -
> =C2=A0* Dropped patches related to 0xE5 support. =C2=A0They will be s=
ent
> =C2=A0 on their own again.
> =C2=A0* Dropped a Kconfig patch that is already on for-linus branch.
> =C2=A0* Removed "Bamboo" references to wireless patch since
> =C2=A0 wireless module works with at least 2 product families now.
> =C2=A0* Delayed enabling monitor interrupt to last possible moment in=
 probe
> =C2=A0 to fix crash reported by Jason Gerecke.
>
> New in v3 - Changed a pointer reset from 0 to NULL.
> Merged Ping's 0xE5 patches into this patch set to resolve
> merge issues.
>
> New in v2 - Updates only to 0xE5 patch set based on review comments.
> No wireless patch changes.
>
> Chris Bagwell (4):
> =C2=A0Input: wacom - isolate input registration
> =C2=A0Input: wacom - wireless monitor framework
> =C2=A0Input: wacom - create inputs when wireless connect
> =C2=A0Input: wacom - wireless battery status
>
> =C2=A0drivers/input/tablet/Kconfig =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
> =C2=A0drivers/input/tablet/wacom.h =C2=A0 =C2=A0 | =C2=A0 =C2=A09 ++
> =C2=A0drivers/input/tablet/wacom_sys.c | =C2=A0230 ++++++++++++++++++=
++++++++++++++-----
> =C2=A0drivers/input/tablet/wacom_wac.c | =C2=A0 49 ++++++++-
> =C2=A0drivers/input/tablet/wacom_wac.h | =C2=A0 =C2=A06 +
> =C2=A05 files changed, 263 insertions(+), 32 deletions(-)
>
> --
> 1.7.7.6
>

There's a fair bit in this patch set that's beyond my knowledge to
properly review, but I can at least provide (for both the 3rd-gen
Bamboo and Intuos5):

Tested-By: Jason Gerecke <killertofu@gmail.com>

Jason

---
Day xee-nee-svsh duu-'ushtlh-ts'it;
nuu-wee-ya' duu-xan' 'vm-nvshtlh-ts'it.
Huu-chan xuu naa~-gha.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
