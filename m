Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705142E7378;
	Mon, 29 Jun 2026 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722916; cv=none; b=WnOekiOV40xQ+vzF2CLBWFccEKFmp98OPvxpfwUhw7ORu3E8D9nngH7Q0vGc0upOfNlVRo/6w52fn+TkH7zXRT889r3nrQz31G0uSgI5Tmt/VbHlE8slvvwiU0zF7TQ0NC79fT+V0r4uw+r7A23l/p2M/z0sV1YkE4CWkSOKYno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722916; c=relaxed/simple;
	bh=Xz4PzrDwzzuaPETJi0ALD7ld+D497D37i0QlLUH9Lyw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AAt0e/rmFv3gsGphxZCYeecgHHer8MB6B7rxqo9cnHBgbBNaCD+T3u3jhQMBGqlp+/OXMrKxk4uOoibuGx82W3Y0QignE6JtturhGH8vRzPAsNxz7ue69T1f0gQVqsylSobZXm9X+q5ctY1ttKJ6lbCzgx0rMRxxjpP6e47ZQ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqBoS++W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqBoS++W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CF01F00A3A;
	Mon, 29 Jun 2026 08:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782722915;
	bh=VTfuWyce6ubPNkpld3KRHsFA0RKYOz5UW1f33Z20s/Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=ZqBoS++WYns6mYeGYOP6mq5lrE3inEPYlrR7TYA5+b7084zvRP+bz9IvRK+uQ2wS1
	 w0OrrNeT8zIEhjjbZ1hI4zIqCGqBYIXlMvfpf6LNl0U+qqKFIe45Opfg+wpm1gYspA
	 HJ+I8fN2ea42lL/FZjsvJf+uADF7mlcAggLCJvL/Ky+AnWCqDDtaZBMG9NfVnC7pqN
	 cursc+GIy0jNItap0eoWV95QdEUVz7oJJGHQzsWTNqomdMym7qqBTx1l0k9Wr6dzgH
	 bJMOFTLr4V3jtyt9Qc4cGGuRKFYmx1trxqtTdUgYS8XMiHe3PUGXaVzPR8JExZRVrr
	 TkOavGjYxnxOA==
Date: Mon, 29 Jun 2026 10:48:32 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Philipp Weber <kernel@phwe.de>
cc: bentiss@kernel.org, eadavis@qq.com, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
    syzbot+9eebf5f6544c5e873858@syzkaller.appspotmail.com
Subject: Re: [RFC PATCH] HID: core: quiesce input in hid_hw_stop() to prevent
 use-after-free
In-Reply-To: <20260519130014.34521-1-kernel@phwe.de>
Message-ID: <o6400s42-5np9-50q5-8576-q29r74747380@xreary.bet>
References: <69eed7e0.a00a0220.7773.0026.GAE@google.com> <20260519130014.34521-1-kernel@phwe.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 19 May 2026, Philipp Weber wrote:

> A driver's probe calls hid_device_io_start() to enable input delivery,
> then fails at a later initialization step and unwinds via hid_hw_stop().
> The unwind frees struct hidraw via hidraw_disconnect() while in-flight
> HID reports may still be running on another CPU, dereferencing the
> freed object through hidraw_report_event(). syzbot reports the
> resulting use-after-free for the corsair-psu HID driver.
> 
> Edward Adam Davis posted a per-driver fix for corsair-psu that adds
> an explicit hid_device_io_stop() before hid_hw_stop() in the probe
> error path ("hwmon: prevent packets from going to driver for probe",
> 2026-04-28). Auditing the tree shows 15 drivers call
> hid_device_io_start(); 7 also call hid_device_io_stop() and 8 do not:
> 
>   drivers calling hid_device_io_start() without a matching
>   hid_device_io_stop() before hid_hw_stop():
>     drivers/hwmon/corsair-psu.c       (fix posted by Edward)
>     drivers/hwmon/corsair-cpro.c
>     drivers/hwmon/nzxt-kraken3.c
>     drivers/hwmon/nzxt-smart2.c
>     drivers/hwmon/gigabyte_waterforce.c
>     drivers/hid/hid-logitech-dj.c
>     drivers/hid/hid-nintendo.c
>     drivers/hid/hid-mcp2221.c
> 
> Roughly half of all callers of the API are exposed. Centralize the
> quiesce in hid_hw_stop() so callers do not have to remember the
> matching stop: if a driver has left hdev->io_started true on entry,
> call hid_device_io_stop() before hid_disconnect().
> 
> For the 7 drivers that already call hid_device_io_stop() correctly,
> hdev->io_started is false on entry, the guard short-circuits, and
> behavior is unchanged.
> 
> No Fixes: tag because the affected drivers gained their
> hid_device_io_start() calls independently over years; the bug is a
> class-wide API misuse rather than a regression from one commit.
> 
> Reported-by: syzbot+9eebf5f6544c5e873858@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9eebf5f6544c5e873858
> Signed-off-by: Philipp Weber <kernel@phwe.de>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

