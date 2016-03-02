From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v3] HID: Support for CMedia CM6533 HID audio jack
 controls
Date: Wed, 2 Mar 2016 10:34:09 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1603021033540.3656@cbobk.fhfr.pm>
References: <1453435183-8342-1-git-send-email-ben_chen@bizlinktech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453435183-8342-1-git-send-email-ben_chen@bizlinktech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Chen <ben_chen@bizlinktech.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 22 Jan 2016, Ben Chen wrote:

> Thanks for your time.
> 
> The C-Media CM6533 is a USB audio chip featuring it's jack detection 
> capability.The device originates an interrupt transfer via HID interface 
> each time when a jack event occurs.
> The purpose of this patch is to handle hid raw events to keep the operating 
> system informed of user interactions.

Applied to for-4.6/cmedia.

-- 
Jiri Kosina
SUSE Labs
