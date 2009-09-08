From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Handling stuck keys
Date: Mon, 7 Sep 2009 23:29:21 -0700
Message-ID: <20090908070244.D5E12526EC9@mailhub.coreip.homeip.net>
References: <5d5443650909070402s33ec5385h49df18821507ea5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.211.173]:46657 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590AbZIHG3X (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Sep 2009 02:29:23 -0400
Received: by ywh3 with SMTP id 3so4553111ywh.22
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2009 23:29:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5d5443650909070402s33ec5385h49df18821507ea5d@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Trilok,

On Mon, Sep 07, 2009 at 04:32:06PM +0530, Trilok Soni wrote:
> Hi,
> 
> What is the preferred way to handle stuck key notification through driver?
> 
> I feel the following scenario would work assuming that controller is
> able to detect the stuck key and gives us an interrupt.
> 
> - Once the interrupt is raised, we go and find out which key is stuck
> through regular key scanning logic.
> - We find the key which is the vicitim and forcefully send "release"
> key event through input_report_key.
> 

Seems reasonable although what prevents the driver to report the stucj
key as pressed again on the next scan? You need to make sure that driver
ignores stuck key... All in all it sounds like broken hardware (not
broken by design, just broken). Do we really need to include workarounds
for such cases?

> I saw other drivers in the input subsystem where people are handling
> keyboard quirks with forceful release, so I hope the same should with
> stuck keys too.
> 

You are probably referrign to atkbd - there the keys arent reallyt
stuck, the firmware designers apparently decided that sending release
events is too much bother for them.

-- 
Dmitry
