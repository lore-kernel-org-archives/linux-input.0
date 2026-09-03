Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54608494828
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442152; cv=none; b=IenBJWXIIZSmhtVJWHRuG9KQZHbMFY3DmLB46Wb8XQxoMpXwZ6gBIoSfGG17gwVF0nJOhEe1j6b0NM4etGKEuRBMxRpIg7YjCT79V+qe5RVWzy9+EWH2J0RsczrnsGrpkrwCAtVkXphsYVQkAWQ1O8D2UrWtsYaAbDnUIwUflNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442152; c=relaxed/simple;
	bh=RzKSbLu0NmlM6Hy44SO9AYuDQH+OSRI3McvED38oAZo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=E9GPOB0apGgkl9O8zZNkQD0jYL41ChWXB3kXFD/u9HNO9ROFTzCZyvnLLaynl8d2LgxQ1UME4zjHf8+sKH1QbkcESA7TV2jcfcz7jhjDpX1wue7i73/TXU/FgUqOVdVLHPEB1a3BEcTEAMIn2LlLyPiXAOUDDe/UaQaQkfYW3nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=lVoh1zk3; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=WxDziwXX; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="lVoh1zk3";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="WxDziwXX"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=lVoh1zk36tEn4K4WY/5lbSKpciyqtptbauiihw5bwEUmtwQt6Mk55/+GtC3JwfCVZFTh3Up3NUs5qajTyDqFkC4+lQMilifkTAQTOQ07UdtBUSx6FoyYkap1CZSmrNIETDzH603LIWNUO/sG14iPPREgsE9QBbJp2sa+dM928bP6EFtq1ugFazz+dik9qqxXgqAkOeiCIizgPuJ4T0dX65R8HJg2tbb7eRX00k5SLu56NHJ/bXhTBxzPCTu2mNtNv0KcDlUogefHQJLkn1pbBrf31WLtQMlAFFFLonom7VsJ+nCEdMzSCDUm4nZnW9K6BwBKlQVNiv7tw5LTcqo63Q==; s=purelymail3; d=rcpassos.me; v=1; bh=RzKSbLu0NmlM6Hy44SO9AYuDQH+OSRI3McvED38oAZo=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=WxDziwXXbDxpS9+P72Bgc3rih9VuPyDPI1FR+Z1JytKbC+7XyvI5/z2rxZkch2GSB5inIOleBZf9+2lUMb+OdfuPl07G4qbZkGoEaSpYMw4txmgluDMWAZ+0/j21iPJoN2pq9eY3/ANYxhH6SCmwWoPWqIzmSmk8XQG1t76ls71J3PWcQoRsoytCVg0c1a4HIGjhEP3bYbnBzR2jUAblqm+xho9j8ViK4nH8OD/zqEMWXRyvLu4yjPFFZ6JbMDi8Fq02sfSn8LrjijGrKGGOWPrPIpvUKwKt/qMqa1bWiFrkosEA5poJYGr62Pgw3YxX29LcFE/ybJ6l9x7KFQ9mug==; s=purelymail3; d=purelymail.com; v=1; bh=RzKSbLu0NmlM6Hy44SO9AYuDQH+OSRI3McvED38oAZo=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -846348127;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 03 Sep 2026 13:28:46 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 10:30:52 -0300
Message-Id: <DL5PV8KZSLAY.10R2KRTZ2YOBH@rcpassos.me>
Subject: Re: [PATCH v4 0/4] HID: wiimote: new LED behavior on connect +
 scoped_guards
Cc: "Shuah Khan" <skhan@linuxfoundation.org>, "Brigham Campbell"
 <me@brighamcampbell.com>, "Jori Koolstra" <jkoolstra@xs4all.nl>,
 <linux-input@vger.kernel.org>
From: "Rafael Passos" <rafael@rcpassos.me>
To: "Rafael Passos" <rafael@rcpassos.me>, "David Rheinsberg"
 <david@readahead.eu>, <bentiss@kernel.org>, <jikos@kernel.org>
X-Mailer: aerc 0.22.0
References: <20260817213840.1053216-1-rafael@rcpassos.me>
In-Reply-To: <20260817213840.1053216-1-rafael@rcpassos.me>

Hi!

[Sorry for the dupplicated email, I sent this in the V3 by mistake ;( ]

I'm looking for feedback in this patchset.
I believe this is a good time,
since the merge window was just closed.
Maybe this could be ready for 7.4 ?

Thanks,
Rafael Passos

On Mon Aug 17, 2026 at 6:38 PM -03, Rafael Passos wrote:
> Hi,
> This patchset contains one feature change, and 3 patches appying=20
> scoped cleanup to locking and to the initialization functions for
> the led probing and the main wiimote probe call.
>
> The feature is turning different LEDs for each of the first 4 wiimotes co=
nnected.
> From id 5 forward, the LED will cycle back to 1, and so on.
> This uses the ida struct, so its quite simple and lightweight.
> The hid_info log message prints out the controller id.
>
> While implementing this feature, I decided to cleanup the code using
> scoped_guard for the many spinlocks in the driver. There are two places
> where the original lock/unlock version fits best, and I left them
> untouched.
> I also used the __free scope cleanup in the wiimote_probe and LED probe.
> This was trivial for the LED probe.
> The wiimote_probe required a new state tracker bitmask, now the wiimote_d=
estroy
> is used both on disconnect (hid_remove) and in the probe cleanup.
>
> It was really fun working with this driver.
> I tested it with 4 Wii Motion Plus remotes (gen2).
> Video recording of my tests (48s video).
> https://rcpassos.me/video/wiimote-led-linux-driver
>
> Thanks,
> Rafael Passos
>
> ---
> V1: https://lore.kernel.org/linux-input/20260710153456.2093889-1-rafael@r=
cpassos.me/
> Changes from v1:
>     (1/3):
>     - fix ida_alloc_min error handling to consider negative values
>     - remove fallback to 1 on ida_alloc_min failure
>     - move player_leds static array to hid-wiimote-core.c
>     - s/instance_id/player_id/g
>     - store player_id on an u8
>     (2/3):
>     - add header include for cleanup.h
>     - add identation to one-liner scoped_guards
>     (3/3):
>     - add scoped cleanup function to wiimote_probe, with a bitmask to tra=
ck state
>       Patch used for testing this:
>       https://lore.kernel.org/linux-input/20260715213513.3929001-1-rafael=
@rcpassos.me/
>     (4/4) *new patch* :
>     - sashiko found a pre-existing uaf. Unlikely, but correct.
>       implemented using the playstation driver as an inspiration
>
> V2: https://lore.kernel.org/linux-input/20260710153456.2093889-1-rafael@r=
cpassos.me/
> Changes from v2:
>     (2/4):
>     - join the last two locks into a single scoped_guard lock in wiimote_=
modules_load
>
> V3: https://lore.rcpassos.me/wiimote/20260729164928.1138468-1-rafael@rcpa=
ssos.me/
> Changes from v3:
>     - dropped false uaf patch (previous 4/4). It was a false alarm.
>       Discussion in:
>       https://lore.kernel.org/linux-input/20260729164928.1138468-1-rafael=
@rcpassos.me/T/#t
>
>     (1/4):
>     - I tested how the changes looked if using ida from 0 instead of 1,
>       and I believe it ended up less clean. I decided to keep them as is,
>       with a few additional comments.
>     - explicit initialization of player_id to 0 before allocating an id
>     - avoid using a new int during ida_alloc (use ret instead)
>     - use u8 instead of __u8
>     - move ida_remove from wiimote_hid_remove to wiimote_destroy
>     - add debugfs entry for the player_id entry
>     (3/4):
>     - move changes to wiimote_probe from this patch to the next
>     - update patch title
>     (4/4): *new patch*
>     - scoped cleanup in the wiimote_probe call, using a bitmask to keep
>       track of state during initialization
>     - update wiimote_destroy so it can be the cleanup function
>     - add a debugfs entry for this new entry
>
> As we discussed in the v3, tell me if you like the changes in patch 4/4.
> If you prefer not to apply it, I can send a new patchset revision, or
> just drop it from the set if nothing else needs changes.
>
> Thanks!
>
>
> Rafael Passos (4):
>   HID: wiimote: turn on the LEDs indicating the controller id
>   HID: wiimote: replace spinlock pairs with scoped_guard
>   HID: wiimote: led_probe with scoped cleanup
>   HID: wiimote: wiimote_probe with scoped cleanup
>
>  drivers/hid/hid-wiimote-core.c    | 346 ++++++++++++++++--------------
>  drivers/hid/hid-wiimote-debug.c   |  71 +++---
>  drivers/hid/hid-wiimote-modules.c |  24 +--
>  drivers/hid/hid-wiimote.h         |  10 +
>  4 files changed, 240 insertions(+), 211 deletions(-)


