Return-Path: <SRS0=X7PX=EE=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C17C2D0A3
	for <linux-input@archiver.kernel.org>; Thu, 29 Oct 2020 15:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED4E1206FB
	for <linux-input@archiver.kernel.org>; Thu, 29 Oct 2020 15:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603984045;
	bh=NJHQhpUrNoZf8PancW9t2WQ+0QXTxWc5qJVxwEWNpyg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=AofDPBMneqHDS+U6VgdAORGV/N+qQ2X/aQTxC0XV31w1NSfQSWkDiU73WLppaL8HX
	 PAU4qQ/+WwPyThvIJv2Sw3MbG5SiyhfUO3UmhJgTR2tPykmRe689vJEyyU9yci+SxY
	 1IMrx/xnJ+TvO5Uo4EQwyj3FgF3P+Pq0eKGLdr30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgJ2PHY (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 29 Oct 2020 11:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgJ2PHY (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Oct 2020 11:07:24 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ABA82072D;
        Thu, 29 Oct 2020 15:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603983659;
        bh=NJHQhpUrNoZf8PancW9t2WQ+0QXTxWc5qJVxwEWNpyg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=FJmeoSHzQduSdGQjGJsOamKUKnXzIdx9clfp2JjKqIJAkkbzDKRmOI6kDQtOFV28K
         ullFp64UwALP/jyLtRLiyCEBOGitVdkfMA5cVvtDgKDx9Sf3c07AwAfOhS6sAgKSSF
         FwGuPD+heZCfSv6nyUKAKFwYKrS6WF6fm9pU7yLI=
Date:   Thu, 29 Oct 2020 16:00:55 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Luke D Jones <luke@ljones.dev>, linux-input@vger.kernel.org,
        andy@infradead.org, benjamin.tissoires@redhat.com
Subject: Re: [PATCH v10] HID: ASUS: Add support for ASUS N-Key keyboard
In-Reply-To: <7b5dd95d-360f-5620-6bd9-3cc2c5d85ae3@redhat.com>
Message-ID: <nycvar.YFH.7.76.2010291555020.18859@cbobk.fhfr.pm>
References: <20201026210216.103501-1-luke@ljones.dev> <7b5dd95d-360f-5620-6bd9-3cc2c5d85ae3@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 27 Oct 2020, Hans de Goede wrote:

> > The ASUS N-Key keyboard uses the productId of 0x1866 and is used in
> > almost all modern ASUS gaming laptops with slight changes to the
> > firmware. This patch enables: Fn+key hotkeys, keyboard backlight
> > brightness control.
> > 
> > Additionally this keyboard requires the LED interface to be
> > initialized before such things as keyboard backlight control work.
> > 
> > Signed-off-by: Luke D Jones <luke@ljones.dev>
> > 
> > ---
> > Changes v8-v10
> > - Remove asus_wmi_send_event and change Fn+F5 to emit
> >   KEY_PROG4. The ASUS G14-G15 laptops have a problem
> >   with freezes if the user spams this key to trigger
> >   asus_wmi_send_event(). It is better handled with a
> >   key-bind and daemon.
> > - Change cases of dev_warn to hid_warn.
> > - Remove out-of-scope changes which are better suited
> >   as separate patches.
> 
> This version looks good to me, and it applies without problems
> (no more removed spaces):
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks Luke for putting this all together, and thanks Hans for 
such a detiled review.

-- 
Jiri Kosina
SUSE Labs

