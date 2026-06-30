Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354C544CF56
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840591; cv=none; b=ZGWqfHUa0yQyw81wWElVdqnLIb5VGfJU1TK7D7uD1WQZQIztJNfbiILpjoccb++rAFsrCuOgmDOjXK6i8yTo1teqc2gTRi4SvAahhYwLJW5VcwMvIZN8R2YbhzHzXXvJ5AgwhtYhXqx9NGnVi18aPpmk6jSR49DW5stN1tzUZvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840591; c=relaxed/simple;
	bh=Z6gbUjW/XxgzCNZMmP2HZHkwRWigZogbRpHJe+fcckY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0nAEbU+EAmXu/KIvUzhSnLTRBWsj97BFKNrUyPVkrK470it5piBYj+8/KCaLNyh8xYrVoUrWYGKOHwOQOSACHsFxlfOKjZl7Bs+ITe1Z1WYGSjEOPzjJb7FI9K43RNmnhmSBQcHFDfWKD/b+0RnQ88VCeGhGfRNUrFyEFWBqXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBLyVQ9D; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBLyVQ9D"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f23e851626so8768256d6.3
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782840589; x=1783445389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B78F1Rnz1PyzO78nWvVsonhs630DctmEHZiwtgkmhqs=;
        b=CBLyVQ9D/komgVT5v1MvRWuqICdvF0Pyhi9eTFO5/WsTLr3UPbKdGChfIhfLOTWEeX
         U7FXMSy4kqCQpjeTT+AFlGTnUIqn0PK9AAmpsoQBqP4qXjFBXAu6BhOs418ozL9/vLLd
         SPPNox2l+R7DunrkkvXJW9W3DjTsbMkuodtSgNQlyWbzxXHqENFS9a2EdaG/bHxNJH9J
         XARd8z7k/Tq/zUynN3/vCigQs96NiSx/x6dr83k/I0CiINqaDtWIUDrrNmRD2RiL5RRp
         sKoSjQynzQ/5s5u4xHBRBBDTVjKaMkn8gIcBoBLa3CQF8FcLSmHYM3As/EIcEmcRzaGM
         Bu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782840589; x=1783445389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B78F1Rnz1PyzO78nWvVsonhs630DctmEHZiwtgkmhqs=;
        b=kC7F/bh01YDwBAn5sMr7fRlW8VEIoVuQEZJgXca5tKwtBiYgWs0WjIuwdaVGN0aAHi
         H1RjKWk9P3YutSG4PCi4jz7yx7xtjltfTPnS0VfiL9dJ/ONgTqsKmxprFmLDU3gVmDBI
         2aEzWk6e0g9SaTk2tNxv7COff+R0h08LCmKUOuVe9vP6FnEWMtKjYBDQDOqMQ+gd1H8r
         od4WGk9jo5Vy6YlDgLOdAsDTukFt7K47yvOQO50ccAJbB0Pub80DcfDiUK1Wwx68UMOt
         99M5SbzDbGnEviWNObzICtvg6YjjQLPHndCV75nuKWHfCqMcfjshtbAzd8w2sdY+5HWQ
         Qi5g==
X-Gm-Message-State: AOJu0YxjW2F6pdP1vMWEAeIfH7OTzl4lFXx8syBC7zUYg1LfTwBXMsTZ
	4PFo7feJiscQupE3LE4i4MNXlZ9M9VZagL0+W0l7MARFernAPeCHJ4F3
X-Gm-Gg: AfdE7clATAsy6A5/8Ww2Lc/N/GKblbOB3GESoUQMBDv8+8Li28QLqZhco+Fzh4Mz5OJ
	PbHccWAGjpKwRslGHIUpGeem8YWPA1fw58NJHbx5guC8zpWOynDXc9xA9QaZBb8m3n2krOOSN8D
	X7QpGhiIcgD+v9CBReeOAtI4iE7eqW8T2j7+2haXhzNHXuBnYFJG1rE2Cp6aW34bxNuCkHq1u3z
	RJ/e4PBTzLfk0SJvLogjXiCBzgKqHiG45Qr7eC0vDBZufoQwni1r8tyEh9aeam3eYB2XHDtJKE+
	Eac5pC0fvWT5hk7g2gD/4dIukYv4V/BShdqzF9cl/boiLSHFcokb0mwr3WfTxBDUsXxlYQDjEly
	+zCio/8vw2Caz7v2eTKoDGqBZfOfnTqJCAQ0q32gyCe76U1MXWiZMt05AEKcyCLgi//n96+qpRC
	C1e+dRgLMYyoa4PAR1isFKyUV+KkHZyiDaaW9jv48iT6gFRhyn
X-Received: by 2002:ad4:5ba8:0:b0:8f0:6185:b633 with SMTP id 6a1803df08f44-8f1bbbded5emr59092966d6.31.1782840583722;
        Tue, 30 Jun 2026 10:29:43 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:122a:dd00:da6a:a6e4:2464:e6a1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a69c32cdsm29822906d6.31.2026.06.30.10.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 10:29:43 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v5 6/9] HID: steelseries: Correct Arctis 9 battery calibration range
Date: Tue, 30 Jun 2026 13:29:27 -0400
Message-ID: <4c63c726222039f205afb217ab220daf7e455dcb.1782840133.git.srimanachanta@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782840133.git.srimanachanta@gmail.com>
References: <cover.1782840133.git.srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Map the Arctis 9 raw battery value over 0x64 (empty) to 0x9a (full)
instead of 0x68 to 0x9d. These values match the HeadsetControl project
[1] and fit the calibration points from an independent reverse
engineering of the battery tray (about 25% at raw 112, 50% at raw 125)
[2].

I do not have this headset. The values come from those references and
were not measured directly.

[1] https://github.com/Sapd/HeadsetControl/blob/master/lib/devices/steelseries_arctis_9.hpp
[2] https://magnier.io/reverse-engineering-arctis-9-battery-tray/

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries-arctis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steelseries-arctis.c
index ce5875c03e73..d1552bf6567b 100644
--- a/drivers/hid/hid-steelseries-arctis.c
+++ b/drivers/hid/hid-steelseries-arctis.c
@@ -141,7 +141,7 @@ static void steelseries_arctis_9_parse_status(struct steelseries_device *sd,
 	if (data[0] == 0xaa && data[1] == 0x01) {
 		sd->headset_connected = true;
 		sd->battery_charging = (data[4] == 0x01);
-		sd->battery_capacity = steelseries_map_capacity(data[3], 0x68, 0x9d);
+		sd->battery_capacity = steelseries_map_capacity(data[3], 0x64, 0x9a);
 	} else {
 		/* Device off: 0x55 (no status) or 0x03 (stale status). */
 		sd->headset_connected = false;
-- 
2.54.0

