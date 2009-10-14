From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [BUG] ati_remote2.c: possible mutex_lock without mutex_unlock
Date: Wed, 14 Oct 2009 00:14:28 -0700
Message-ID: <20091014071428.GA5318@core.coreip.homeip.net>
References: <1255456327.22233.0@pamir> <alpine.LSU.2.00.0910131736571.8582@wotan.suse.de> <20091014062902.GA2971@core.coreip.homeip.net> <alpine.LSU.2.00.0910140906280.8582@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:58349 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755572AbZJNHPI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Oct 2009 03:15:08 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.00.0910140906280.8582@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: iceberg <strakh@ispras.ru>, Vojtech Pavlik <vojtech@suse.cz>, Linux Kernlel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Wed, Oct 14, 2009 at 09:11:06AM +0200, Jiri Kosina wrote:
> On Tue, 13 Oct 2009, Dmitry Torokhov wrote:
> 
> > Umm, I don't like assuming that EAGAIN can only mean that 
> > mutex_lock_interruptible() failed, seq_file core may theoretically 
> > return -EAGAIN too. In fact, looking through seq_file.c traverse() does 
> > return -EAGAIN in certain cases...
> 
> Damn, you are right -- I explicitly checked for this, but have completely 
> overlooked the "Eoveflow:" branch in traverse(), which returns EAGAIN. So 
> my previous patch is of course incorrect.
> 
> > Input: fix locking issue in /proc/bus/input/ handlers
> > 
> > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > input_devices_seq_start() uses mutex_lock_interruptible() to acquire
> > the input_mutex, but doesn't properly handle the situation when the
> > call fails (for example due to interrupt). Instead of returning NULL
> > (which indicates that there is no more data) we should return
> > ERR_PTR()-encoded error.
> > 
> > We also need explicit flag indicating whether input_mutex was acquired
> > since input_devices_seq_stop() is called whether input_devices_seq_start()
> > was successful or not.
> > 
> > The same applies to input_handlers_seq_start().
> > 
> > Reported-by: iceberg <strakh@ispras.ru>
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> Yup, looks OK to me.
> 

Putting you as "Reviewed-by.." then, OK?

-- 
Dmitry
