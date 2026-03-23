Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E30E3BC693
	for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281682; cv=none; b=Ba6Fn2Q/YTZUHbzLlaL6WxvmWdTH6vtpPtyjwf0mLEhRq1w+qzpqUayWjwNkFfCx+/1UOaq12iTeLO/tQhsyoLKq/HdAKBSyaZ4J7QUtkUoZFxoiYfXfAGsEfMPD2kj55/iiMtiyC1sBjy5YQcAnQaJv4QzOREwiqDHj6kTF8ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281682; c=relaxed/simple;
	bh=0DPJh0DJ3iDimFvMQsoeZlDl8P4qbc82fRy/khoEFVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mo0eYWaV1lICAdIJ0wSzjkUDAOGeVtKDsOGkFxbzhZhAjbWHjUNxVb/jKx73M+iMRKKW/pp475QIJGE9A3WNKwuimVIpR7oBp+CSP481NRXvQDHDvpiUrhw+Yu4peHwEB16wOKU6r/EA/BjVTJ+wDcZ/6DVPMJ9L3FJ61K8Yp0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=eXYheOu+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="eXYheOu+"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-829ac4670c4so3298638b3a.0
        for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 09:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281681; x=1774886481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eViZzzv8Sc/M5QSGBQX9CwMHZ/34uumJnzvDlBpaGpc=;
        b=eXYheOu+D0OT+Q8vs06kyy5MMRp1gLVxHh22oWfojhSo6d60zQyitdxX7Yo7HhgKE+
         /0roFXfNXloX/veakhuqrWnv1GNdd064sbhS9dCVENk9G9C9fe3QSGH7U4qrCHkxjKSh
         VjFrPZMMs1n5/r1SmpQCW4y4sqepgzdS3qxpfKRS/0GLyEgjdeKERGNGLTrNmyqyhAPw
         OgLTxs6U9dqnOhQWM/A9oIoxC2Wrw839ZofSBVKX1d7XQ37ygQh6MkuOyGBAJptQkJEo
         AakLrqqRu2awDpTf30T/hb/B3oePe88KizAyeA+xAPdsGgcJoJkRE52xQ7veXbsc2711
         UEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281681; x=1774886481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eViZzzv8Sc/M5QSGBQX9CwMHZ/34uumJnzvDlBpaGpc=;
        b=jsJ9KoSFYX6G5yrmEQGkBCbCAnchDgbdUH2OObd5w+0SbPlf3plBAPPabfURydFWXX
         Czs9nF7ltIQ18vXEj846uf7Lf6SNgteuc+PNo+lHIvB/igZIQ2PUDZXElCEhuYc83LeY
         BA87dXdoW3k3nXBF3SV/bkWt6XJXwdWFtRgVyG6ijj2cDRty7xhTGwfXLzUzqrkMSfb0
         PHb5Cf6bWU/6fAS9JI/sLtSUOBk0A2ag29eJa4/DzWycgNlCrSLTWsyHw+ds3xT1saGY
         fPpTFkE278k0Eg7n+HsYgCf3l5zFNYg6MCoRTuiE/fMGWt23VOAuQWBMznnIgh+MBfbU
         BmBA==
X-Forwarded-Encrypted: i=1; AJvYcCUFiH4MuwCte1Vlm5V/3V4g5aw/FWl/pzdfJynCaN0BwFMa+I9wbSMwYqFxZxtSW7xgCzDxkV7ntnvhAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhSfmpU+bW1ETbxOfqZhYhwbnNxMHjEgiEerIVW3ZKpIfmTetu
	HJS3f005iP1cBAWlZqDjExuA1AFPEQ6vjJkmugP1XZPCMGLyQo8ppTYs4sviPBNpZLxPw7Ap5zU
	TKKFeqIAbag==
X-Gm-Gg: ATEYQzw2h7BQ3uI6vF04HVDYjwo5wBidrJ9TEzO3jjgHIfrIEDCtcRc0ok5FCRstvTI
	LH2fpfnQ13Cr9jvDZR0kjh8VDr4LL6S5Ni5O+P6ODYlqUj4MVn3ybUU6UhtJMH1QxyPyrXmZfXn
	wQ84NNkETD5p18WifyYeXznyldk4PiuPflaa4iev0PcL2luFXupbOZDFlUWr5+bSFAcezbSlYwg
	6ilW365yJG3vZpvB/g1MvoJZGJ161fT3EZJRVqVzLuVaJqpI+jlt8neM5iHp2vX+a02NVY2HrvL
	XOzEYs2//6vnbvvCuamh8godo5GcPqOfoq+ZUEQwMFIcoGCK0Rr3H7+xVqDDahpW1eIlQhe5q3W
	jgGriiPvtahAXHgU152VgJOBiTeFMoh1qwiLdK9O/7NXsyMS+cFdhxfV2eqKD6SMjUxVPY+JTgu
	XzPZ0zmI4PD6AsCktYXTwyf2VgLrnWJAT9rBDrYBhTxUw2KBXxBQT+wyEsHXnKDr+C3A==
X-Received: by 2002:a05:620a:198a:b0:8cd:8d4c:aa0c with SMTP id af79cd13be357-8cfc7a796e7mr1828317285a.0.1774281661473;
        Mon, 23 Mar 2026 09:01:01 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:00 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dmitry Ilvokhin <d@ilvokhin.com>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jon Maloy <jmaloy@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	dev@openvswitch.org,
	Jiri Pirko <jiri@resnulli.us>,
	Oded Gabbay <ogabbay@kernel.org>,
	Koby Elbaz <koby.elbaz@intel.com>,
	dri-devel@lists.freedesktop.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Len Brown <lenb@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	linaro-mm-sig@lists.linaro.org,
	Eddie James <eajames@linux.ibm.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	linux-fsi@lists.ozlabs.org,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alex Deucher <alexander.deucher@amd.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-spi@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/19] tracepoint: Add trace_call__##name() API
Date: Mon, 23 Mar 2026 12:00:20 -0400
Message-ID: <20260323160052.17528-2-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add trace_call__##name() as a companion to trace_##name().  When a
caller already guards a tracepoint with an explicit enabled check:

  if (trace_foo_enabled() && cond)
      trace_foo(args);

trace_foo() internally repeats the static_branch_unlikely() test, which
the compiler cannot fold since static branches are patched binary
instructions.  This results in two static-branch evaluations for every
guarded call site.

trace_call__##name() calls __do_trace_##name() directly, skipping the
redundant static-branch re-check.  This avoids leaking the internal
__do_trace_##name() symbol into call sites while still eliminating the
double evaluation:

  if (trace_foo_enabled() && cond)
      trace_invoke_foo(args);   /* calls __do_trace_foo() directly */

Three locations are updated:
- __DECLARE_TRACE: invoke form omits static_branch_unlikely, retains
  the LOCKDEP RCU-watching assertion.
- __DECLARE_TRACE_SYSCALL: same, plus retains might_fault().
- !TRACEPOINTS_ENABLED stub: empty no-op so callers compile cleanly
  when tracepoints are compiled out.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 include/linux/tracepoint.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 22ca1c8b54f32..ed969705341f1 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -294,6 +294,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
 		}							\
+	}								\
+	static inline void trace_call__##name(proto)			\
+	{								\
+		__do_trace_##name(args);				\
 	}
 
 #define __DECLARE_TRACE_SYSCALL(name, proto, args, data_proto)		\
@@ -313,6 +317,11 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
 		}							\
+	}								\
+	static inline void trace_call__##name(proto)			\
+	{								\
+		might_fault();						\
+		__do_trace_##name(args);				\
 	}
 
 /*
@@ -398,6 +407,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define __DECLARE_TRACE_COMMON(name, proto, args, data_proto)		\
 	static inline void trace_##name(proto)				\
 	{ }								\
+	static inline void trace_call__##name(proto)			\
+	{ }								\
 	static inline int						\
 	register_trace_##name(void (*probe)(data_proto),		\
 			      void *data)				\
-- 
2.53.0

