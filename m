Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C993C73FE
	for <linux-input@vger.kernel.org>; Thu, 12 Mar 2026 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327941; cv=none; b=mVPxghWFePvmpH2toCeThvjAeRnF9UcQqqGjOSsmnSvf9s1V7fSZG4hQ837YSu28BEq9J8ZS+JPUYBlf5OEuVBtsldKE3aQcga8QX81lycmPiI7XFtNfwdUtxQBENL3QRd0MCHMi6nVhIYglRAzdiSuNQ2ev5M/nfmJcQZTyAVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327941; c=relaxed/simple;
	bh=10NVZYZNHh8UNRWWgIond7aYsxXBLnPZEqS+81FpWlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lknd+h+JS7FCnyk/X3TFj+h9flfJ8Elmfv7iFd5XV2drOqR/8kzd9q8j9OC8nCbtGx/5XMLPuZZ2ZctlbQeeG0WcnHC0b2XCqz2JisdBJyVFDp78v9qPqOp/PKp0BTc/lXACOcxePFm0L7dq1/+v5cV/wQ+2pb3v/Kc1wiEkwgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=ZLuEADjS; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="ZLuEADjS"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d7422b4ff1so506270a34.3
        for <linux-input@vger.kernel.org>; Thu, 12 Mar 2026 08:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773327938; x=1773932738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNc1V3lTb2QUW0xjd0W9BOVRtnhujjy4WaV1yGr6BKQ=;
        b=ZLuEADjS5Wujf+hyGJOkQpr/wIKGuXs9OOEVT4XriJwtaGHICDf/fK7wgqCLEVshea
         ZPDoxRigGndBOJZknOWOvmoIvA5p5AflGvpUg/lYA1HOMVjGphlSfEEp2YUKFkCpsUjq
         iY7dYM6BX9/OyYunBFKZ1LEEd+dgcchthClyw8FTO8bR13lJBq1OLNQ6XV+bQEoEw0nW
         hc0H26Q0dFwWj47erVfvxfR6mSo6cPUE9ccQuUXIqrq+LZpon6yRikG/EMTJ4kvhBZ6x
         p+knU1eLD3OrfrwQaFIiU9k98YYy4T5TDHuUp8m0AMRLXmoPg+ykG9oMleXMnBAqpVBq
         0UAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327938; x=1773932738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cNc1V3lTb2QUW0xjd0W9BOVRtnhujjy4WaV1yGr6BKQ=;
        b=Q+8AxKLS9RMmqMFjaTRGPeihr16LSTQfRCfDBldhlM/7/7mqtfLybkpP7gsyuv9Q1E
         uRuZV9nFjBEwlLZrrb4ck6nfh/FeNcO6BG6i2aLEp0DxQyZSEqJhxVopMBNg5Iy47jbc
         6iuF5ZetwiGADLbjIxyBshEY/SIJXIlS6EwP0oI2U5u1iMO9LmbbIubGAn225RtG3ot2
         tN0zjLqFEfdzETi36IC2ep9RgNvIoeG0dQKk9fUt395cQ5pl5I0ZSmNw9SN2Mu6Wj50c
         t0Yrd1RPNW9SvN/K18WAq9phLT5pjwc3ul3W8By8+2Bvb8O83d/+FX86Tum1xlCBToIf
         N7xg==
X-Forwarded-Encrypted: i=1; AJvYcCXsBQMs7TgUx2OLod1ZdvEfYKMLtO6g+7xNamfXmnC9MwYCxvODHfJ300A1eW6tBpfWKiN5XQvCxEv1xA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvVeoxRYsrKByjtdiA1FUBNoS2bScjklkHdK2S3DzcnKJlou+V
	q/feW4BqpvRItCHSnqkOD6c1cyNv9xMc+FmjZXaLUDIJM+iJBGFMn16achjvBole9uE=
X-Gm-Gg: ATEYQzwiZf6/0unv1V/WKdfigobRw5sfqgudOoyQCKxmlz/nkgQSlRtG629dQ71Kp+c
	68xfjay8hWv7NNumxB1a9WETJh5eksqMY5l4R8fsGZAkhkbcA9Af9fuYtomlP0butjiv0uK4tjo
	ynfu+ztqDv3blYpouSs7j+PXiVGLZOGBeIFMkiBHsHAeysadxHtzawsZr5oDZ0moWoywVBkTYOj
	3wWQObfae+1Jq/BfzfGfAJuXNZYQ/aEnLMvy+AUKOxIB4vq/Zi8RwguGGKm3M0bTkAXwonkZoqT
	ejvdZ5FX1putHSGs5DSeWmgp5da9SVy/kq1GmPjF6xSlUfZYwZIsGzSplWu+kKoKvVzxb7mEsGQ
	Yl9ulzHZy6T4qu+CwbJsogQA9HGaTTew0/ouX5S42+1oAXn/pyu4zHb/DPF0jfLrUUHAq/Sf0Kj
	5A3sNnzpioibJXuZ/ER75B/4fxrmkJmX6Oox/vDvZJWjDu/OvtGxWzfC6+U4ALN3vagqUPqLkql
	B2e
X-Received: by 2002:a05:6830:3113:b0:7c6:d001:afb2 with SMTP id 46e09a7af769-7d76a85b34cmr3668805a34.35.1773327936791;
        Thu, 12 Mar 2026 08:05:36 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:05:36 -0700 (PDT)
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
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] tracepoint: Add trace_invoke_##name() API
Date: Thu, 12 Mar 2026 11:04:56 -0400
Message-ID: <20260312150523.2054552-2-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add trace_invoke_##name() as a companion to trace_##name().  When a
caller already guards a tracepoint with an explicit enabled check:

  if (trace_foo_enabled() && cond)
      trace_foo(args);

trace_foo() internally repeats the static_branch_unlikely() test, which
the compiler cannot fold since static branches are patched binary
instructions.  This results in two static-branch evaluations for every
guarded call site.

trace_invoke_##name() calls __do_trace_##name() directly, skipping the
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
index 22ca1c8b54f32..07219316a8e14 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -294,6 +294,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
 		}							\
+	}								\
+	static inline void trace_invoke_##name(proto)			\
+	{								\
+		__do_trace_##name(args);				\
 	}
 
 #define __DECLARE_TRACE_SYSCALL(name, proto, args, data_proto)		\
@@ -313,6 +317,11 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
 		}							\
+	}								\
+	static inline void trace_invoke_##name(proto)			\
+	{								\
+		might_fault();						\
+		__do_trace_##name(args);				\
 	}
 
 /*
@@ -398,6 +407,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define __DECLARE_TRACE_COMMON(name, proto, args, data_proto)		\
 	static inline void trace_##name(proto)				\
 	{ }								\
+	static inline void trace_invoke_##name(proto)			\
+	{ }								\
 	static inline int						\
 	register_trace_##name(void (*probe)(data_proto),		\
 			      void *data)				\
-- 
2.53.0

