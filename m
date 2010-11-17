From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 1/2] Drivers: hid: Makefile: Cleaned up Makefile
Date: Wed, 17 Nov 2010 14:05:52 +0800
Message-ID: <20101117052123.GA5282@cr0.nay.redhat.com>
References: <1289141188-1447-1-git-send-email-tdent48227@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40762 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932824Ab0KQGBK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Nov 2010 01:01:10 -0500
Content-Disposition: inline
In-Reply-To: <1289141188-1447-1-git-send-email-tdent48227@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tracey Dent <tdent48227@gmail.com>
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, chatty@enac.fr, spbnick@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Nov 07, 2010 at 09:46:27AM -0500, Tracey Dent wrote:
>Changed Makefile to use <modules>-y instead of <modules>-objs because -objs is
>deprecated and should now be switched. According to (documentation/kbuild/makefiles.txt).
>
>Signed-off-by: Tracey Dent <tdent48227@gmail.com>

Acked-by: WANG Cong <xiyou.wangcong@gmail.com>
