From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: Add support for PDP Xbox One controllers
Date: Mon, 22 Jan 2018 11:25:33 -0800
Message-ID: <20180122192533.5bjek4ibrregkmqf@dtor-ws>
References: <20171210185208.08d7e52c@volta>
 <c3e05db2-801e-72d6-ebce-6a27ffaef538@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45321 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbeAVTZh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 22 Jan 2018 14:25:37 -0500
Received: by mail-pg0-f67.google.com with SMTP id m136so897594pga.12
        for <linux-input@vger.kernel.org>; Mon, 22 Jan 2018 11:25:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <c3e05db2-801e-72d6-ebce-6a27ffaef538@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>
Cc: "Mark Furneaux (by way of Mark Furneaux <mark@furneaux.ca>)" <mark@furneaux.ca>, linux-input@vger.kernel.org

On Mon, Dec 11, 2017 at 09:42:11PM -0800, Cameron Gutman wrote:
> On 12/10/2017 03:52 PM, Mark Furneaux (by way of Mark Furneaux <mark@furneaux.ca>) wrote:
> > Input: Add support for PDP Xbox One controllers
> > 
> > Adds support for the current lineup of Xbox One controllers from PDP
> > (Performance Designed Products). These controllers are very picky with
> > their initialization sequence and require an additional 2 packets before
> > they send any input reports.
> > 
> > Signed-off-by: Mark Furneaux <mark@furneaux.ca>
> > 
> > ---
> > Changes in v2:
> > 
> > - Zeroed the sequence numbers and removed the redundant quirk entry.
> > - Corrected mangled formatting from my email client.
> > 
> 
> Thanks, LGTM.
> 
> Reviewed-by: Cameron Gutman <aicommander@gmail.com>

Applied and earmarked for stable, thank you.

-- 
Dmitry
