From: James C Boyd <jcboyd.dev@gmail.com>
Subject: Re: [PATCH 0/3] HID: hid-input: Simplify expression and suppress gcc
 warning
Date: Wed, 27 May 2015 19:52:54 -0500
Message-ID: <20150528005253.GA731@noodlelt.attlocal.net>
References: <cover.1432761541.git.jcboyd.dev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34145 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbbE1Aw7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 May 2015 20:52:59 -0400
Content-Disposition: inline
In-Reply-To: <cover.1432761541.git.jcboyd.dev@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, May 27, 2015 at 07:17:17PM -0500, James C Boyd wrote:
>   HID: hid-input: Add parenthesis to suppress gcc warning

I suppose I should also mention that gcc-5.1 was reporting
this dumb warning. I'll resend the patch set with that detail
mentioned if you'd like.
