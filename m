From: Dag Bakke <dag@bakke.com>
Subject: Re: [PATCH] fix apple alu keyboard with numpad
Date: Thu, 08 May 2008 19:29:14 +0200
Message-ID: <4823386A.6000501@bakke.com>
References: <4814612F.5030606@bakke.com> <20080506125406.dc047710.akpm@linux-foundation.org> <20080506234307.GA27714@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail47.e.nsc.no ([193.213.115.47]:58341 "EHLO mail47.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754005AbYEHR34 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 8 May 2008 13:29:56 -0400
In-Reply-To: <20080506234307.GA27714@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Diego 'Flameeyes' Petteno <flameeyes@gmail.com>

Matthew Garrett wrote, On 05/07/2008 01:43 AM:
> On Tue, May 06, 2008 at 12:54:06PM -0700, Andrew Morton wrote:
> 
>>> -static int hid_apple_fnmode = 1;
>>> +static int hid_apple_fnmode = 2;
> 
> Regardless of anything else, we don't want this hunk.
> 

Was my reasoning for this change off ("F-keys used more often that 
multimediakeys, ergo make that the default"), or is your resistance to 
this change due to some kind of policy?

Sorry if the reason is obvious to you. It isn't to me, yet.


Regards,

Dag B
