From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: mousedev: Emulate right and middle buttons
	for single-button touchpads
Date: Wed, 10 Sep 2008 08:52:28 -0400
Message-ID: <20080910125228.GA25221@anvil.corenet.prv>
References: <48C0893C.6060901@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:37984 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbYIJMwd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Sep 2008 08:52:33 -0400
Received: by an-out-0708.google.com with SMTP id d40so441698and.103
        for <linux-input@vger.kernel.org>; Wed, 10 Sep 2008 05:52:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48C0893C.6060901@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: akpm@osdl.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Henrik,

On Fri, Sep 05, 2008 at 03:19:56AM +0200, Henrik Rydberg wrote:
> On most linux-based systems, the right and middle buttons are used
> extensively. On computers lacking either of those buttons, such as
> the Apple Macbooks, emulation is needed. This patch adds emulation
> of the missing buttons via two-fingers-and-click and three-fingers-
> and-click operations, which has recently become standard, both in
> MacOS and in the Xorg synaptics driver.
> 

The standard way of emulating right and middle button presses for
"button-deficient" devices is to use Macintosh emulation
(MAC_EMUMOUSEBTN) that works not only for touchpads but for regular mice
as well.

Overall I don't think we should enhance mousedev for scenarios where
proper solution is to install Synaptics X driver. This also goes for
your other patch improving tapping in mousedev.

-- 
Dmitry
