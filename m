From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH/HP7XX] - Fix touchscreen build error ( LONG() usage )
Date: Tue, 16 Sep 2008 14:29:18 -0400
Message-ID: <20080916182854.GD9252@amd.corenet.prb>
References: <20080916200857.028a5bb0.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:10619 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbYIPS3Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Sep 2008 14:29:25 -0400
Received: by an-out-0708.google.com with SMTP id d40so278528and.103
        for <linux-input@vger.kernel.org>; Tue, 16 Sep 2008 11:29:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080916200857.028a5bb0.kristoffer.ericson@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, Sep 16, 2008 at 08:08:57PM -0700, Kristoffer Ericson wrote:
> This patch removes the usage of LONG() which is deprecated inside
> the jornada720_ts.c file.
> We also replace BIT() with BIT_MASK().

Applied, thank you Kristoffer.

-- 
Dmitry
