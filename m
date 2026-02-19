Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F45228850B;
	Thu, 19 Feb 2026 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771525066; cv=none; b=omjQiU9N4PVOhFHLQwGZ6aIVb7nnCu6tGFVYxOfpr172Xj+6DHSogad/p548A6DwvVSRZWkAdRVzKu/xIWXvNDpB+4d98QcvjxQLUtdKYwiYjSgIeFZUuLOW7PyANaWNhRJWG8L6kjVnK9wcUSLsZ/AtTn2aQNo38QlbUf+T9tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771525066; c=relaxed/simple;
	bh=ABiFYFF9fj0W78Gc+ZFJiL6KzGpzLWkFRG1Ukf4IW0E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MVwRzTe9pmnLenuSIa3YMHa+DjEh/KUZU/ivtiq1FxAzMyDrF5+LkAZCLLEZgvHiKxgw35cbMrura+cz+vlgRlqkc8InaP9bl/v6WCEIH8cjgXPEcPNqDzF2hqiJyIXo5s/DQTk2J0PfzuY/NP3xuIG45oqH7u6FJbLcb6jh534=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUui565e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUui565e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417ECC4CEF7;
	Thu, 19 Feb 2026 18:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771525066;
	bh=ABiFYFF9fj0W78Gc+ZFJiL6KzGpzLWkFRG1Ukf4IW0E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WUui565eKrvcl+RmkEH8b5b58AGTP5SAtW/++kRN7ts6JMkT+uWWreVxYcST1zqZl
	 Rq1cJBLa8fexyzJ8j+T4kDlJjZ2sBfJHlnQ7c7s79/r2ndtU+gdqmJDOqlrE51UiSQ
	 CoK/+IAVhVja732OLKd9yU6AowN1PzrQH1SolS0oeQszp/DXL0GGQYe78ofu8VP52H
	 QrQRL+7urdDm7b2i280kotuXEs6ZAjqJMseRlv33ayhoVWGx/0pmldM/Nd95IQ01L8
	 QmkTIoaFba6LSLYdwn6ee5l0j7g9XWUVsj0JKkkVnn3tx7YOkhriFRUziJtr80xDk8
	 +oFMah8HL3EPw==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260219154338.786625-1-gnoack@google.com>
References: <20260219154338.786625-1-gnoack@google.com>
Subject: Re: [PATCH v2 0/4] HID: Fix some memory leaks in drivers/hid
Message-Id: <177152506493.1014432.13997635109456483651.b4-ty@kernel.org>
Date: Thu, 19 Feb 2026 19:17:44 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3

On Thu, 19 Feb 2026 16:43:34 +0100, Günther Noack wrote:
> These patches fix a few memory leaks in HID report descriptor fixups.
> 
> FWIW, a good ad-hoc way to look for usages of allocation functions in
> these is:
> 
>   awk '/static.*report_fixup.*/,/^}/ { print FILENAME, $0 }' drivers/hid/hid-*.c \
>     | grep -E '(malloc|kzalloc|kcalloc|kmemdup)'
> 
> [...]

Applied to hid/hid.git (for-7.0/upstream-fixes), thanks!

[1/4] HID: Document memory allocation properties of report_fixup()
      https://git.kernel.org/hid/hid/c/6b3e458806e3
[2/4] HID: apple: avoid memory leak in apple_report_fixup()
      https://git.kernel.org/hid/hid/c/239c15116d80
[3/4] HID: magicmouse: avoid memory leak in magicmouse_report_fixup()
      https://git.kernel.org/hid/hid/c/91e8c6e601bd
[4/4] HID: asus: avoid memory leak in asus_report_fixup()
      https://git.kernel.org/hid/hid/c/2bad24c17742

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

