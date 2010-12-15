From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] msm: trout: add keypad support
Date: Wed, 15 Dec 2010 08:48:41 +0100
Message-ID: <20101215074841.GB2483@ucw.cz>
References: <1291854285-29566-1-git-send-email-dwalker@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:40180 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752766Ab0LOHst (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Dec 2010 02:48:49 -0500
Content-Disposition: inline
In-Reply-To: <1291854285-29566-1-git-send-email-dwalker@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Walker <dwalker@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org, arve@android.com

On Wed 2010-12-08 16:24:45, Daniel Walker wrote:
> This adds matrix keypad support, and gpio buttons support for
> trout's various keys and buttons.

Yeah, but everyone knows trout as 'HTC Dream'.

> +static const uint32_t trout_keymap_evt2_1[] = {

u32?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
