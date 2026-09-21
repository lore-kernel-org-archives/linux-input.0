Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13DE4B4893
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790011485; cv=pass; b=gFXx4hVW7l8VV1EaaZ6ZaPugK7L1bDhLaB+gBsRbsR6mHQJnRVu0esljYFkBw0t8si299zk3FRBT3MZ5m6mhx3k5GxJxji2BU5A7GQ6Axtc+o/Ijg8FPREytWpg6C6XrOnjRFPpIe1oMcUl+FScikAfjoGFzfYPDWSxhoSlzkYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790011485; c=relaxed/simple;
	bh=/v0KnOInrE/uxrVKcrgbiXLeViQuxHndnnvuHrKDtYE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uhIERiSQmxUkexqb3C2N/gZhoVpaxutDi9yeH5AgWudo66ELFGx4Wr67fbNvQkKrGf0Cbdw5CAOTQzcu4B1zRrHTwi9RVrgliCXChejvud8uJThRhIhGUByUy2NN/8JpX68Ue2yzUZgKM3ew87C/GCmc8CfKwTiDf84Bl6zFnaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X9Gry/EK; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X9Gry/EK"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2db33db4de9so9615ad.0
        for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 10:24:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790011484; cv=none;
        d=google.com; s=arc-20260327;
        b=Izy7pY8VEwnEET02gL41zX6WBx04Q4UXRaBhyea1Ccy4TkHLsmCfLHOyFzN9Cg2QXo
         HBdoJZ9U5MmIfxpC6HMgZqtNJmh0yDGlSJGRsu1bCx5zNuqgNHmG8lLsv0VWzvs4DD6z
         Xp6r5y1y6Tz9V95z9TWgK87eArna+JTN8KEBFNaJkKQofELJJ39OfjRncNGfuZ1tKeEl
         86Jvhw5KNR3Jg1YhhPO9Ymswr2y85cEmohm/OZ7Px60bQWPBIhog2EEXzV/zCiiKCLbK
         sFfhw/6hUfwLJ+i36CezGJJUQc969mZbzoPAoRvAcF0eVbjD+44jy1ofwPg3Rm69knt4
         BWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/v0KnOInrE/uxrVKcrgbiXLeViQuxHndnnvuHrKDtYE=;
        fh=/c0JXnxQ5ur+uTLoJNUdn5IDzJIQCnsMD54CJyaKqRE=;
        b=Qvf/xr6QHhiUVKTDSAjXzKXGzW2pCdLzqeChBWaMJN7m0+4uwdvZtoEr1IPimqc9MU
         yTj+bqgEnkAYzLcUIokPSEAtHMF+JA2szDfNDRoVCgNfqMg6ztkuI/f3ZQT1m1LjUv/h
         FB7KNoNDTMGk2mgUp1E2sTc8n3ZOqdvEArqOqRKJ5Epgu0V9FviHtQ+gyjHO5hHMMtjb
         XQ6qZYn2GfLs0Rzq57aZW3MtltSg45eiN2RwhJdlKawqbvSIbFTFp/IypChZHspBFyJ9
         fD/rypyMzYxYhnhrG5lVGwrfl4uM8FSlBqVxPgiiTgxs+GKQ5sMsOzzGjqY0km4xG3mt
         RmLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790011484; x=1790616284; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/v0KnOInrE/uxrVKcrgbiXLeViQuxHndnnvuHrKDtYE=;
        b=X9Gry/EKIR0oA3WvRxssW5CbY/4aLhKAvkvNN2Y5Yf+onpizzgG+z7nWeV0abPV1vi
         TnjAMogewj+QdGC+OGhLmEC8fQttHBvim8VPe4c71LSKQiU8oKC7pGbytCEUCUi2XJBz
         PMdftrvoZRpkH+PIvlOzLL/bEtaalWpJW5mYTA/Dy0XCmZ8VnWCylPUpMlr/RNBhP6OH
         /xxEVzCmgstuO+eA14QntGsrh5dKmuFcR6ftHLLhuFOFfoojUo78JA47WCybxu6RijgE
         UTQ697MYObZ4yl9ZtYv/PDmXJCJu7Xt5cB1yg2PYdxO5NSIj8484d6sBJqcGnN8SvXjY
         I9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790011484; x=1790616284;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/v0KnOInrE/uxrVKcrgbiXLeViQuxHndnnvuHrKDtYE=;
        b=ur6rsmitdZLE41j3WOFxa6VP5MyL9aE1YzMs0XjcQLDyNNlXwt1AImklMNKwKgWHdK
         gaIogcQQO7R5sBP2AaO5IUQ9i050gDFnY7puE/bn9p0ke4b7TURZ2Gg7+XhpeNcYm9eU
         vbZioWUWDi7DWGHZrU/8wbjB482mlB1ZwiLZ07HnbFMJzIzc4dXDRx/yAB6VavHgzjta
         EGjZmJ8nfbmDEVuzmImXZSwPfEQaqN5EjJgt0fBu/bPDoefIu6BCvhYcGy3fOT6NyuqG
         cT6BXqsqnLqX2Qg0bJmPCmc5CKsnf9w7HfE5oxPcRZftCDvr1vv04iLpk1m794EfxvGp
         6ZGg==
X-Forwarded-Encrypted: i=1; AKwUvBx+5DnJBkzMDDSgUPcy0cuCiPcEKoyjinYVTwFKBYOQN7qCTJhEW+kDILNoj64SuW7kDWyqv0mmdPstQw==@vger.kernel.org
X-Gm-Message-State: AFuF++n5J8AkRoppqD47/5VBA/rkbasfXDHX5G0jKoKekEOVxX8ImtI7
	FQnxdnbx5FvQGa9An5dlaoylLL3SUjXkleQ4gHOln6Smw7X+Qvz3VKiqwwa6ZJiGXhSCLzOqQEx
	rO6qeAHCf/tLZTyOlJdkeLanTyQRlKCtNTHpfnOgE
X-Gm-Gg: AYBFou0TLVCk/Ia8KNHjbsrrRSX0Y2dTfP+IRTQoWhNPS3H67jqMTWsDZ3XdXZvIrB0
	bAa+/eDQnsUrsUrHu2HupRephIlZ4RsoAcILLsr3/tE7fK/rdnL+EyJhTolIbKQ3aGCAoqn9Sro
	IMQEX43kehW+txifQ9ZejOiWfGvxB9QOeUfznkBBtzl3epCq4YWCDQn+XyPJnbkEmUTfZ7VbYIo
	MK3qBFlYNCR472lqA5m1damhAlrtatEPyPtg0CNGKwFKw/WqknJcZ5OC3G+yFn0cpDVQcqZh90x
	Q/dEo+NER2W5S/iSdO7Xoroy8P7tRnW7Gw2oO9PB8Sx1ZTYI0ja+hAexEztyNa41n0/4GWNk6Mn
	jxjgmJwaNGFRqifEO0tM7OXLov2QmcnYkTAcbHZNF
X-Received: by 2002:a17:902:bb87:b0:2c7:f0cc:dafa with SMTP id
 d9443c01a7336-2df5a6593cemr125095ad.5.1790011483066; Mon, 21 Sep 2026
 10:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jann Horn <jannh@google.com>
Date: Mon, 21 Sep 2026 19:24:06 +0200
X-Gm-Features: AcwNN1U7svCPIdkwDP9pPf0HOHZjW_TisEKhV3E71X43wo60ibp0-Yv4z4MLOjc
Message-ID: <CAG48ez2N4jPTF7mqs28NHNNH+ev3xFqE+FJ2OgaehAw8L+w91w@mail.gmail.com>
Subject: HID: intended semantics around report buffer length?
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org
Cc: kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi!

I've noticed that some HID drivers seem to assume that HID events come
in buffers of at least HID_MIN_BUFFER_SIZE bytes for historical
reasons. As a random example, elo_raw_event() can pass the supplied
buffer to elo_process_data(), which can access data[1..7] without
checking the size parameter.

However, HID-BPF exposes the kfuncs hid_bpf_input_report() and
hid_bpf_try_input_report() which appear to allow BPF code to pass any
buffer with size >=1 into this codepath.

What is the intended API contract for buffers passed into
hid_driver::raw_event? Are HID drivers allowed to assume that these
buffers are always >=HID_MIN_BUFFER_SIZE bytes (in which case I think
HID-BPF probably has a bug), or are all HID drivers without explicit
size checks buggy?
