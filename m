From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2] Input: evdev - Add EVIOC mechanism to extract the MT
 slot state
Date: Fri, 6 Jan 2012 19:55:44 +0100
Message-ID: <20120106185544.GB2795@polaris.bitmath.org>
References: <1325863019-2242-1-git-send-email-rydberg@euromail.se>
 <CAN+gG=FUEH851Um4Lco0avqdE2Eup3Jo79Ti4T7XhxT=PO6WeQ@mail.gmail.com>
 <20120106181845.GA22653@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:38239 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756639Ab2AFSzr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Jan 2012 13:55:47 -0500
Content-Disposition: inline
In-Reply-To: <20120106181845.GA22653@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Chase Douglas <chase.douglas@canonical.com>

> 2 different processes should be fine; the problem would be if 2 threads
> of the same process share the same file descriptor. So far the rest of
> evdev copes just fine with multiple threads using the same fd (all
> operations are atomic in this regard), setting ABS_MT_SLOT before
> fetching the state break this property.

Are we talking about the need for a per-client mutex, or something
more subtle, like introducing indirect coupling between threads
through per-client states? The former ought to be easily remedied.

Henrik
