From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 00/14] alps: bugfixes, cleanups and new hardware support
Date: Fri, 25 Jul 2014 22:59:02 -0700
Message-ID: <20140726055902.GB31435@core.coreip.homeip.net>
References: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:55527 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbaGZF7H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Jul 2014 01:59:07 -0400
Received: by mail-pd0-f175.google.com with SMTP id r10so6801398pdi.34
        for <linux-input@vger.kernel.org>; Fri, 25 Jul 2014 22:59:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org

Hi Hans,

On Wed, Jul 09, 2014 at 05:24:05PM +0200, Hans de Goede wrote:
> Hi All,
> 
> This series started out as a single patch to add support for a new model
> of alps touchpad, called PROTO_V7 in this patchset.
> 
> While working on this I ended up doing some refactoring as preparation, which
> I tested on a Rushmore alps touchpad, which lead to some bugfixes and more
> cleanups, etc.
> 
> The result is a 14 patch patch-set, which:
> 
> 1) Significantly improves multi-touch support on V3 and V4 models (including
>    the Rushmore V3 variant)
> 2) Improves the code quality / readability quite a bit
> 3) Adds support for PROTO_V7

Excellent series, very easy to read. I have applied everything but v7
support as I have questions about that patch.

Thanks.

-- 
Dmitry
