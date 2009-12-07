From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Force Feedback core memory leak
Date: Sun, 6 Dec 2009 22:26:05 -0800
Message-ID: <20091207062605.GE21451@core.coreip.homeip.net>
References: <1259931914-6228-1-git-send-email-ext-jari.vanhala@nokia.com> <1259931914-6228-2-git-send-email-ext-jari.vanhala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:43661 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbZLGG0D (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Dec 2009 01:26:03 -0500
Received: by ywh36 with SMTP id 36so4008115ywh.15
        for <linux-input@vger.kernel.org>; Sun, 06 Dec 2009 22:26:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1259931914-6228-2-git-send-email-ext-jari.vanhala@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jari Vanhala <ext-jari.vanhala@nokia.com>
Cc: linux-input@vger.kernel.org

On Fri, Dec 04, 2009 at 03:05:14PM +0200, Jari Vanhala wrote:
> Effects is allocated, but not freed anywhere.

Applied, thank you Jari.

-- 
Dmitry
