Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F772411F95;
	Mon,  3 Aug 2026 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785785667; cv=none; b=FjsnrtXeXAN6RnEMdLoXDf9qpRaxiZBzx7Db7alh2RXbw/hgKygteCJ9PN9vOMGJ6uomt1BeU3mLKsEUte+oxnoEjfnLNZP9VIOC0ppQekJVNNsGlcUp8PIjUFoVRtPdRDm4aQDFq6cGqqGCZaUy8I8zBKzZ3yheSFIVZpsnVXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785785667; c=relaxed/simple;
	bh=RqoQ6UunlrjqPtx6Q/q6HjBr0J51Wwv6BMP5v5ytv6g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZCGHAwxhrCJdq96QRX9OA9ctDIPVgG2bY5Wl2DW+slDTKGdZNize2VsetI1DJx9zLwT/sYECW91NBZerm1jDjKGPYmAXOI+YDrQveoTFQw7ZNdu0aY50XfDSRaiz+jQwzg0OCiPHiITAXPCHw+EoFM2lJYr709wS6oFkuZTYS+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+3XLKn7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+3XLKn7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769BD1F000E9;
	Mon,  3 Aug 2026 19:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785785666;
	bh=EUWTKArFspuxIYJ93m8xyZ/hFqmBn5DFVBj+5W9vX5E=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=I+3XLKn75Rq1PUsf+p8fqWIlRd5/1qxLtOIm+Mf86l1oNp6XbByIOMf18/M8W5Yhw
	 zZSshNtJtNpe+XY4gwkZ1eH57n9w2SMhXw+6LTpoKxS5zJNdL9n2MDIPVSJw36Kvl1
	 8vebvId9J2pSLAhnnh8rDh2ImWbLADK3MIPt3FuD3QryJb1KCArSgcZNQRVWa8rT+H
	 kTUuLrWra1GvDeWEWL75DZYBX0/o/FnPD3U3+WaXk+gnp8HzmBN4eREhf5wpARYYiZ
	 UmO01Bw6kDEPNQ4g20e5OgRV7nbWtPjKQHYWLVkzSozl4WA8ONdBJVX1CBvhF+VSZ0
	 L0hJSKukT7YAQ==
Date: Mon, 3 Aug 2026 21:34:23 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com, 
    syzkaller-bugs@googlegroups.com, Vicki Pfau <vi@endrift.com>
Subject: Re: [PATCH] HID: hid-steam: fix uninit-value access in
 steam_get_serial
In-Reply-To: <0c5f5bcd3d01776615a97d7f23b5c1bff6a2acce.1781092734.git.xiaopei01@kylinos.cn>
Message-ID: <85n82qo4-q3q8-8052-1qnr-n7qo12p2p01n@xreary.bet>
References: <6a27d055.39669fcc.33b062.008d.GAE@google.com> <0c5f5bcd3d01776615a97d7f23b5c1bff6a2acce.1781092734.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

CCing Vicki Pfau here ... could you please give your Ack to this fix?

Thanks.

On Wed, 10 Jun 2026, Pei Xiao wrote:

> The reply buffer in steam_get_serial() is allocated on the stack without
> initialization. In cases where steam_recv_report() returns a short read or
> an error, not all bytes of the buffer are written, leading to subsequent
> access of uninitialized memory when checking reply[0], reply[1], reply[2].
> 
> Zero-initialize the reply array to prevent KMSAN uninit-value warnings.
> 
> Logs:
> hid-steam 0003:28DE:1102.0007: unknown main item tag 0x0
> hid-steam 0003:28DE:1102.0007: unknown main item tag 0x0
> hid-steam 0003:28DE:1102.0007: :
> USB HID v7f.fd Device [HID 28de:1102] on usb-dummy_hcd.1-1/input0
> =====================================================
> BUG: KMSAN: uninit-value in steam_get_serial drivers/hid/hid-steam.c:457 [inline]
> BUG: KMSAN: uninit-value in steam_register+0xd83/0x10e0 drivers/hid/hid-steam.c:965
>  steam_get_serial drivers/hid/hid-steam.c:457 [inline]
>  steam_register+0xd83/0x10e0 drivers/hid/hid-steam.c:965
>  steam_probe+0x6f1/0x19b0 drivers/hid/hid-steam.c:1273
>  __hid_device_probe drivers/hid/hid-core.c:2822 [inline]
>  hid_device_probe+0x60d/0xb90 drivers/hid/hid-core.c:2859
>  call_driver_probe drivers/base/dd.c:-1 [inline]
>  really_probe+0x4d5/0xe40 drivers/base/dd.c:709
>  ...
> 
> Local variable reply.i created at:
>  steam_get_serial drivers/hid/hid-steam.c:448 [inline]
>  steam_register+0x180/0x10e0 drivers/hid/hid-steam.c:965
>  steam_probe+0x6f1/0x19b0 drivers/hid/hid-steam.c:1273
> 
> Reported-by: syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/6a27d055.39669fcc.33b062.008d.GAE@google.com/
> Fixes: c164d6abf384 ("HID: add driver for Valve Steam Controller")
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>



> ---
>  drivers/hid/hid-steam.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 197126d6e081..f65ad1a21c01 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -445,7 +445,7 @@ static int steam_get_serial(struct steam_device *steam)
>  	 */
>  	int ret = 0;
>  	u8 cmd[] = {ID_GET_STRING_ATTRIBUTE, sizeof(steam->serial_no), ATTRIB_STR_UNIT_SERIAL};
> -	u8 reply[3 + STEAM_SERIAL_LEN + 1];
> +	u8 reply[3 + STEAM_SERIAL_LEN + 1] = { 0 };
>  
>  	mutex_lock(&steam->report_mutex);
>  	ret = steam_send_report(steam, cmd, sizeof(cmd));
> -- 
> 2.25.1
> 

-- 
Jiri Kosina
SUSE Labs

