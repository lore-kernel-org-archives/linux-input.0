From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 0/3 v2] input : wacom - Split the 4/4 of a previous set
Date: Tue, 5 Jul 2011 21:37:50 -0500
Message-ID: <CAGzDe_YBzQQXCq=eiLtiP_SB2H0zEpnu7CaH_6QLJRbSBi=odg@mail.gmail.com>
References: <1309908268-18755-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63756 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab1GFChv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 22:37:51 -0400
Received: by iwn6 with SMTP id 6so5716819iwn.19
        for <linux-input@vger.kernel.org>; Tue, 05 Jul 2011 19:37:51 -0700 (PDT)
In-Reply-To: <1309908268-18755-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, rydberg@euromail.se

On Tue, Jul 5, 2011 at 6:24 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> Split the "Update Graphire and old Bamboo tablet buttons" into a set =
of
> 3 patches as suggested by Henrik.
>
> Dmitry, please apply the 3/4, "Remove BTN_TOOL_FINGER for pad", patch
> before this set since they depend on that patch.

=46YI: After reviewing, these 3 patches appear to be bisectable... So
its a merge issue only that it needs older 3/4.

>
> Ping Cheng (3):
> =A0input : wacom - Add serial number for Graphire4 and old Bamboo
> =A0input : wacom - Update Graphire4 and old Bamboo tablet buttons
> =A0input : wacom - Cleanup a return value for the old Bamboo
>
> =A0drivers/input/tablet/wacom_wac.c | =A0 22 ++++++++++------------
> =A01 files changed, 10 insertions(+), 12 deletions(-)
>
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
