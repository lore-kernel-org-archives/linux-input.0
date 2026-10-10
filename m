Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E549C367F4A
	for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791640145; cv=none; b=aSJD1QQ9+JeK+93uKp/LYNU/PSZPAwUF0g6+Af9YhebxQ4UQHTvC4yyr9RJk+mMB3Pue/DePQCLXt9XE5povNryrj9XdFKPgoyEGaDgNYfHtyaJ/fed/u+VjqGe1uvEw2BaQw9vBFEvVV90fvwm3oT6HjxBio6kTmqndVGGZjU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791640145; c=relaxed/simple;
	bh=MgS3AEUVPRpcN55hZd5xfi5t4pjX0Iurq2Q5bJVcUnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fb9Z+KYdauC7snMNN2BSz38Q9VsKzs3efn9Kp1TfOcUiZ4Dx6WSdu4MSyDpNCsunGH/HfG6B0Iemm614gyp2mJFzUEAX1Zo2G7tVut3szhY+qOMFu+3cBBXf5HorCmx9heS2ZaBPoCjOfGLnMd90oCPMM/iBgzm2aDvLew7HYOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=m1f1URTA; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="m1f1URTA"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-917b78dfe30so12030036d6.0
        for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 06:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1791640143; x=1792244943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tdm1TxznS8Z9AVlEqsfQUaZdl9GVN7DC6/4QW7CmuQs=;
        b=m1f1URTAivH9y1fDuVJ8sC35Wg5m+2cLuagzCWkwO5PyQl78pi2SMbsjN8Fr5WdbE1
         +bAukqhbMIvekXkFgSa248EQ+EM2+pfGczcTu6LxrsH3jhMofKPTkKcG31xK3ea2nb9v
         +X0RdMPa1mobf5PiX3ioa+MEgY8GidF6hkduBXUlPl4kZqX+GdWMa5dHd9hf3L7IUA6T
         tSYY79drDY6MOmYvYiJUyM19N/0LEP6svMO8GjupTs5Bj2Gl2KgqAzDtqT5fCR5Dmg3Y
         dotqseM6N9Qdam9oH9jFHaaQ3PAZNpEysqMG2BRoC61qdhtcWuTKFJd8nNBcrf1x1hCY
         QYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791640143; x=1792244943;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tdm1TxznS8Z9AVlEqsfQUaZdl9GVN7DC6/4QW7CmuQs=;
        b=OciiUu78vXS21/AJvHNSY7aQzRi/84y0izQs+n21C+jdf7A9kSp327ObXfnM7XZrpp
         UZ3IAGgk0cxgHoFnC8I0F0YJ1aipF/4Izv+2siXydkwnu+zKD0XcW9yhYn43by+Hy9MB
         odwz3FxBgMeZd03BVfe8eVyUi7Mktm6pWi+1xJREbWT+16vrcmRlc59y1NLKK/WYsAks
         iOSg3HbfcM0Jyf0B9/yIy4nA3SRcGVGvLGR08Z+Zlx1rTVWoqZFJc1sV2/WJr/wrZ3Vh
         zPUypCqIg+uCysn7FJEuapbTZSi4yeIFdgRbXrbmClPxwNNN5QFalgdsM8kU9QeiMTJv
         S2Qg==
X-Gm-Message-State: AFq9FYLLol3nor9tQrn3fy//gsp1ftgY6F20a650rkZgnQaz3czXy6HS
	GngPl3jBLTiVApVQLEWxFdWdOPyAhC/W2JBWrgvIAGgm24dfLvDRZtU9Ib8p34ED6w==
X-Gm-Gg: AYBFou2Mt2Dssl07YT1ggYoTbTSo07JvHq2iwBwfXgdMZgGI6O81Ic6Cp92N68zPwR3
	bRAISf3w/4VNw+z//FVPqsfH3AY05QXyseeUaQP0MWAxghZtuLntP2w8x6SmxYiCZptbPJs6m6a
	rik4uTEyIuGHaCuXWGdLGbJUlijsdINXTjUwbH0oH9Q17cbdst0ZvyIXNNZg7qxCd+PBi2AQ5ru
	+pAGGNzHdLHRRqlh6miGtSChXDvxMwGNc2HMfOy0rncMldPyo6qtNDUFN8bs1RDKsEAPPZFh9Ij
	t7AEtdWhUlZo/5OxrWebFm75SgEvV5KoFCSjlDr5IJ4A4CUiTCpOpe3G1pcHXuRymoJA33j5HML
	a/rzp4/cJ1T1rFNLtGu/LCdkMkRreL690As+aYaVgSAFOzQ4+KVZnLKqTj66doukeZMUHwTJpAX
	YVSPV40LQkvppDQ33P3jesA2iXPq0V+Rs/0C8Peak7M6qBTKoT4dl5kOJVa0DU/OIKF7XMNp0=
X-Received: by 2002:a05:6214:2f90:b0:914:4eff:e88e with SMTP id 6a1803df08f44-91b55574847mr79043426d6.41.1791640142564;
        Sat, 10 Oct 2026 06:49:02 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::1b7d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b5501859fsm45217386d6.16.2026.10.10.06.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 06:49:02 -0700 (PDT)
Date: Sat, 10 Oct 2026 09:48:59 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+25a1d2907885b2182275@syzkaller.appspotmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] UBSAN: shift-out-of-bounds in s32ton (3)
Message-ID: <f10557f6-fe56-4f3e-b138-c1624465a15e@rowland.harvard.edu>
References: <6ac9cbd8.a150a118.27e199.0025.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ac9cbd8.a150a118.27e199.0025.GAE@google.com>

On Fri, Oct 09, 2026 at 10:23:36PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5926a7da8789 Merge 7.3-rc6 into usb-next
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=11fc7ff5580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7f0127eb11110629
> dashboard link: https://syzkaller.appspot.com/bug?extid=25a1d2907885b2182275
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124fc715580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174ed835580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0667b4f9388e/disk-5926a7da.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0a1f8551bcab/vmlinux-5926a7da.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/03e51d6db4ed/bzImage-5926a7da.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+25a1d2907885b2182275@syzkaller.appspotmail.com
> 
> usb 4-1: config 0 interface 0 has no altsetting 0
> usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> usb 4-1: config 0 descriptor??
> ------------[ cut here ]------------
> UBSAN: shift-out-of-bounds in drivers/hid/hid-core.c:80:21
> shift exponent 32 is too large for 32-bit type 'int'
> CPU: 1 UID: 0 PID: 780 Comm: kworker/1:2 Not tainted syzkaller #0 PREEMPT(lazy) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/16/2026
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
>  ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
>  __ubsan_handle_shift_out_of_bounds+0x279/0x2a0 lib/ubsan.c:494
>  s32ton.part.0.cold+0x1b/0x26 drivers/hid/hid-core.c:80
>  s32ton drivers/hid/hid-core.c:71 [inline]

Converting a signed 32-bit integer to a signed 32-bit integer should be 
a no-op.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git 5926a7da8789

Index: usb-devel/drivers/hid/hid-core.c
===================================================================
--- usb-devel.orig/drivers/hid/hid-core.c
+++ usb-devel/drivers/hid/hid-core.c
@@ -71,8 +71,8 @@ static u32 s32ton(__s32 value, unsigned
 	if (!value || !n)
 		return 0;
 
-	if (n > 32)
-		n = 32;
+	if (n >= 32)
+		return (u32) value;
 
 	a = value >> (n - 1);
 	if (a && a != -1)
