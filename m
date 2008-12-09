From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: Re: [RFC 2.6.27 5/5] Add support for E-Ink Broadsheet controller and AM300 kit
Date: Tue, 9 Dec 2008 21:35:46 +0800
Message-ID: <f17812d70812090535h69fa6c15t4b7c50a29955dc42@mail.gmail.com>
References: <12257601131298-git-send-email-jayakumar.lkml@gmail.com>
	 <12257601541179-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:36318 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbYLINfr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Dec 2008 08:35:47 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1629101rvb.1
        for <linux-input@vger.kernel.org>; Tue, 09 Dec 2008 05:35:46 -0800 (PST)
In-Reply-To: <12257601541179-git-send-email-jayakumar.lkml@gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-input@vger.kernel.org

On Tue, Nov 4, 2008 at 8:55 AM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> This patch adds support for the E-Ink Broadsheet display controller and the
> AM300 gumstix kit.
>
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>

You may want to break this patch into two pieces, one for the base
broadsheetfb support and another for the am300epd board.
