From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/4] input: wacom - Wacom Bamboo Pen D4 has 1024 pressure level
Date: Fri,  1 Jul 2011 08:59:51 -0700
Message-ID: <1309535991-1960-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58851 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863Ab1GAP6X (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Jul 2011 11:58:23 -0400
Received: by iwn6 with SMTP id 6so2899617iwn.19
        for <linux-input@vger.kernel.org>; Fri, 01 Jul 2011 08:58:23 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: rydberg@euromail.se
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On Thu, Jun 30, 2011 at 10:18 PM, Henrik Rydberg <rydberg@euromail.se> wrote:

    > Hi Ping,

    > On Fri, Jun 24, 2011 at 05:14:58PM -0700, Ping Cheng wrote:
    >> Instead of 512.
    >>
    >> Reported-by: David Foley <favux.is@gmail.com>
    >> Signed-off-by: Ping Cheng <pingc@wacom.com>
    >> ---

    > Perhaps one could elaborate the commit message a bit - in particular
    > since the text mentions 512, whereas the patch seems to change from
    > 256?

Nice catch, Henrik. 512 was a typo. Does this commit message work:

It is reported by Ubuntu users that Wacom Bamboo Pen D4 has 1024
pressure level instead of 256.

Ping

    >>  drivers/input/tablet/wacom_wac.c |    2 +-
    >>  1 files changed, 1 insertions(+), 1 deletions(-)
    >>
    >> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
    >> index 2ea0d2e..1cbb9a8 100644
    >> --- a/drivers/input/tablet/wacom_wac.c
    >> +++ b/drivers/input/tablet/wacom_wac.c
    >> @@ -1462,7 +1462,7 @@ static const struct wacom_features wacom_features_0xD3 =
    >>       { "Wacom Bamboo 2FG 6x8", WACOM_PKGLEN_BBFUN,     21648, 13530, 1023,
    >>         63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
    >>  static const struct wacom_features wacom_features_0xD4 =
    >> -     { "Wacom Bamboo Pen",     WACOM_PKGLEN_BBFUN,     14720,  9200,  255,
    >> +     { "Wacom Bamboo Pen",     WACOM_PKGLEN_BBFUN,     14720,  9200, 1023,
    >>         63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
    >>  static const struct wacom_features wacom_features_0xD6 =
    >>       { "Wacom BambooPT 2FG 4x5", WACOM_PKGLEN_BBFUN,   14720,  9200, 1023,
    >> --
    > 
    > Thanks,
    > Henrik 
