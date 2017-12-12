From: Cameron Gutman <aicommander@gmail.com>
Subject: Re: [PATCH v2] Input: Add support for PDP Xbox One controllers
Date: Mon, 11 Dec 2017 21:42:11 -0800
Message-ID: <c3e05db2-801e-72d6-ebce-6a27ffaef538@gmail.com>
References: <20171210185208.08d7e52c@volta>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:43817 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbdLLFmN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 12 Dec 2017 00:42:13 -0500
Received: by mail-pf0-f171.google.com with SMTP id e3so13420043pfi.10
        for <linux-input@vger.kernel.org>; Mon, 11 Dec 2017 21:42:13 -0800 (PST)
In-Reply-To: <20171210185208.08d7e52c@volta>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Mark Furneaux (by way of Mark Furneaux <mark@furneaux.ca>)" <mark@furneaux.ca>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On 12/10/2017 03:52 PM, Mark Furneaux (by way of Mark Furneaux <mark@furneaux.ca>) wrote:
> Input: Add support for PDP Xbox One controllers
> 
> Adds support for the current lineup of Xbox One controllers from PDP
> (Performance Designed Products). These controllers are very picky with
> their initialization sequence and require an additional 2 packets before
> they send any input reports.
> 
> Signed-off-by: Mark Furneaux <mark@furneaux.ca>
> 
> ---
> Changes in v2:
> 
> - Zeroed the sequence numbers and removed the redundant quirk entry.
> - Corrected mangled formatting from my email client.
> 

Thanks, LGTM.

Reviewed-by: Cameron Gutman <aicommander@gmail.com>
