From: simon@mungewell.org
Subject: Re: [PATCH 1/2] HID: hid-lg4ff: Use Private Data
Date: Mon, 2 Apr 2012 13:01:30 -0400
Message-ID: <44acbf3ff0b6aa62eab2831ee6ecea80.squirrel@mungewell.org>
References: <a4e40aa5c43be934d83240849aa25f3b.squirrel@mungewell.org>
    <1333378444-3117-1-git-send-email-simon@mungewell.org>
    <4F79D486.5090605@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:39155 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab2DBRBc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Apr 2012 13:01:32 -0400
In-Reply-To: <4F79D486.5090605@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Michael Bauer <michael@m-bauer.org>, Michal Maly <madcatxster@gmail.com>


>> +	struct lg4ff_device_entry *uninitialized_var(entry);
>> +	struct lg_drv_data *uninitialized_var(drv_data);
>
> You don't need uninitialized_var bloat anymroe, right?

I guess I don't fully understand the 'unitialized_var()' macro, and was
just following the previous uses in the code.

Google'ing doesn't really help either. Is there a definitive guide as when
to use and not?

Simon

