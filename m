From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/3] HID: wacom: Move Graphire raport header check.
Date: Wed, 16 May 2012 21:43:33 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1205162143190.8796@pobox.suse.cz>
References: <1337106748-28437-1-git-send-email-przemo@firszt.eu> <CAF8JNh+_Jm7Nwppi6quS_8s=J7R0SXvGX+vV--LsUJzjqZdU0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38190 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964799Ab2EPTnm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 May 2012 15:43:42 -0400
In-Reply-To: <CAF8JNh+_Jm7Nwppi6quS_8s=J7R0SXvGX+vV--LsUJzjqZdU0w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Przemo Firszt <przemo@firszt.eu>, linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 16 May 2012, Ping Cheng wrote:

> On Tue, May 15, 2012 at 11:32 AM, Przemo Firszt <przemo@firszt.eu> wrote:
> > That check is valid only for Wacom Graphire, as the device raports always
> > start with 0x03. Intuos4 WL high-speed raports begin with 0x04, so
> > the check would be filtering out valid reports.
> >
> > Signed-off-by: Przemo Firszt <przemo@firszt.eu>
> 
> Acked-by: Ping Cheng <pingc@wacom.com> for the series.

I have applied the series. Thanks to both of you,

-- 
Jiri Kosina
SUSE Labs
