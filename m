From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/5] input: twl6040-vibra: remove mutex
Date: Tue, 19 Apr 2016 01:01:50 -0700
Message-ID: <20160419080150.GB13933@dtor-ws>
References: <cover.1461009340.git.hns@goldelico.com>
 <592912a81a86fe0c9b5eaf3407cc5c4e1bfef9fe.1461009340.git.hns@goldelico.com>
 <20160418212048.GB1006@dtor-ws>
 <6E9FA6EF-660C-44AE-8BF4-03A21F0DB043@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35846 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbcDSIB7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Apr 2016 04:01:59 -0400
Content-Disposition: inline
In-Reply-To: <6E9FA6EF-660C-44AE-8BF4-03A21F0DB043@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, letux-kernel@openphoenux.org

On Tue, Apr 19, 2016 at 09:49:01AM +0200, H. Nikolaus Schaller wrote:
> 
> > Am 18.04.2016 um 23:20 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > 
> > On Mon, Apr 18, 2016 at 09:55:41PM +0200, H. Nikolaus Schaller wrote:
> >> The mutex does not seem to be needed.
> > 
> > twl6040_vibra_suspend() and vibra_play_work() may run concurrently, no?
> 
> Hm. I don't know about the rule that would give an answer to this question...

Sorry, that was actually a statement, not really a question. It is
possible (although very unlikely) that userspace posts play request and
workqueue will not run until after suspend callback.

Thinking about it some more I wonder if we better do what
twl6040_vibra_close() does and cancel the work before shutting off the
device, so that there is no chance of work executing after suspend
callback and reenabling the device. This way we can indeed remove the
mutex.

Thanks.

-- 
Dmitry
