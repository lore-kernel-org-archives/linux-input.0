From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: 2.6.31-rc6 (yeah, I know...): weird tty / X.org state currently
Date: Thu, 10 Sep 2009 09:25:00 -0700
Message-ID: <20090910165837.50544526EC9@mailhub.coreip.homeip.net>
References: <20090910103126.GA17742@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f172.google.com ([209.85.221.172]:56776 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbZIJQZB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Sep 2009 12:25:01 -0400
In-Reply-To: <20090910103126.GA17742@rhlx01.hs-esslingen.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 10 September 2009 03:31:26 am Andreas Mohr wrote:
> Possibly the kernel's control key state got stuck in a weird state,
> perhaps due to some input layer race conditions or so.
>
> Or is it X.org's input handling which is responsible for Ctrl-Alt-F1
> etc. combos? I wouldn't think so...

X is solely responsible for handling input when active. It switches
console in RAW mode which bypasses kernel processing) and does it's
own thing. This includes switching VTs upon Ctrl-ALt-Fx.

-- 
Dmitry
