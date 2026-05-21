Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4377834A3D6;
	Thu, 21 May 2026 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374752; cv=none; b=EtwMen++KKkrTviUUUItCP1AM4LaKbc0aOhNUCAz/sfzDWdBWMXggUXAStgoMlTEJ2qnAsXqeBMBburi8l7nXr2WOnIkclm2Rj9+GzazkBwafbh9LpZnR9W//dq7pfa0bF2WEyT8DQbjqyZN5f8VdahF+d/pGPihhA7mwMyCSo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374752; c=relaxed/simple;
	bh=FCGMzNMlnqNwjuBAE3MtGaXkVDPXh5fco7c5PJgB4gE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f25J8NGbibunQTWxnKPsJxF1/UwJ3Ra69GJYC1CX2BwSJ6fZc6F6fU0ucH6LHCnBqOCr8bpnz3tHnE7Bur+uDCgsTY0RBzEy/4cGjVqP7n4cpsSLa2Cmebby0qs2F28VFd+F8/0tDypkfDzl/Vv5xwWTN3iG5r3FAtFWzg629/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnlDcD7w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnlDcD7w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BDD1F00A3B;
	Thu, 21 May 2026 14:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374750;
	bh=7EQR2eGuhn01mbWURSyEIfwo4f+H5VNxX9k7aAFO/D0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=VnlDcD7wFlMGJlqjKcj5JVd9mrvGbTm3GZk0dGJ0rxABxeu6tAjjqNXke/LxOH/5d
	 T5WZOlPPWuYCsfZZSK/rPGSUSK2iSKNSKvzNOu4LswxNz0hzsVjMgWWP1TvYKfw0zO
	 ITSCYrXsvGYIbynwWNnScmVJpDoY8UUX4VJl+L+7eKYrrPzk7mu0cVJHhsXRMZKEAT
	 V6v4opF6GYqfA/u0GmyhiGf4dJLEz3jL9KmaIHfnRrgvaZ7FY41oW4MjrSzc3zFZPN
	 q0ngnzCk2hiCwtTpeRxqA5AscCkeFCsVdjBbb8MAYgOubUOEqq3WMyi9cPugHd0hDp
	 aCAXCUQ0GV+tw==
From: Benjamin Tissoires <bentiss@kernel.org>
To: jikos@kernel.org, 
 =?utf-8?q?=E5=88=98_=E5=87=AF?= <lukace97@outlook.com>
Cc: vi@endrift.com, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <OS3PR01MB7969C09559DC6C0DCA520720C73C2@OS3PR01MB7969.jpnprd01.prod.outlook.com>
References: <OS3PR01MB7969C09559DC6C0DCA520720C73C2@OS3PR01MB7969.jpnprd01.prod.outlook.com>
Subject: Re: [PATCH] HID: remove duplicate hid_warn_ratelimited definition
Message-Id: <177937474966.1109683.11669732379919404021.b4-ty@b4>
Date: Thu, 21 May 2026 16:45:49 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2

On Thu, 07 May 2026 08:41:08 +0000, 刘 凯 wrote:
> The hid_warn_ratelimited macro is defined twice in include/linux/hid.h:
> at line 1317 (added by commit 4051ead99888) and at line 1339 (added by
> commit 1d64624243af).
> 
> The second definition is correctly grouped with other ratelimited macros.
> Remove the duplicate definition at line 1317.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.1/upstream-fixes), thanks!

[1/1] HID: remove duplicate hid_warn_ratelimited definition
      https://git.kernel.org/hid/hid/c/dd2147375a8f

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

