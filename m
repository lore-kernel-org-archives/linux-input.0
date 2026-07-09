Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1F03F167C;
	Thu,  9 Jul 2026 07:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582308; cv=none; b=C4ibNaqhbln0VT631aI4SSQnpG0yVTENICvx/45Ef0/BI0S8YDoJYJ+lqL3qEZ8kq5bc7WXFaENvazQBo8SQ63pAz3oumi/GZOp0baJ7ugdpT7dgvW4l75pRRWb9y2O7c0uvZ3UXw6KAbSAWbZ0+bKZ96JFhgImnrlYgeQHElkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582308; c=relaxed/simple;
	bh=r2Vy4nNTq6ACTmPgV1xDQq/FI2rVdI0TWMMyV50cj8g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d2gWE6DVWN+AJhOPAR/ukVFpK5wgmoa4EuwhtXNwFv54NKQ7GC6EhcRFbE5Ydf7VNSH5DAHDU48nb5zFrf4EVTD8TvmhLKapLZLuIqK2AVLptmJdrifNN6zi8CbK4D+YnYIxDv4jlBxIgYWq79vfFjvZRh5l0Fo0obfo+/Wyj6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=I19pnlWK; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="I19pnlWK"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66961i7c1538874;
	Thu, 9 Jul 2026 07:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=eA3MTiXtY
	yTni0B0f6Nf5Bat3+jkUpM3WeQ3yKZHw0o=; b=I19pnlWKJ2wBsu4Y1Nlt7xKhY
	3OAEu8RAQnRZFEIyS/plO97F4A4jAdu5kSFwUbwF9lzbEL/E8jBKxQwtHmy9Otpb
	wE58PqOL+iBDhZgHG5e9HSn8vQx9zUaSSerUE9Ojqt/0amIKaUysqw9KZU84/Cje
	KnKVRvDRx37Yh913ZS1cY6Oixf5cSATVyJ/asZmTXgDWLthtPIHjSKCV3hoPo3EJ
	RnCHkOv6jR7kHD0+oA84Tl7b+wWCGrop0xBKiAKlzZC6T+2/F0YHfn/OC9yjNoNf
	GxhzaZU8t6g55qGu8T/YRellWfMNNkrKvHgspQtInN2lgMv6XCWJbZB56RD5g==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fa1h20e2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 09 Jul 2026 07:31:36 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 9 Jul 2026 00:31:35 -0700
Received: from pek-lpd-ccm6.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 9 Jul 2026 00:31:33 -0700
From: Xue Lei <Xue.Lei@windriver.com>
To: <dmitry.torokhov@gmail.com>
CC: <aeh@db.org>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Xue.Lei@windriver.com>
Subject: [PATCH] Input: cm109 - fix URB double-submit due to missing open check
Date: Thu, 9 Jul 2026 15:31:33 +0800
Message-ID: <20260709073133.373657-1-Xue.Lei@windriver.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a4f4e58 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=gr0OwbfcZWQph8TKZxIA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA3MCBTYWx0ZWRfX3lhfSbZe6oB7
 5NWILRyqeBftRTTLFm2Hr53Ow05BcEFkMs2N5WzWXrj5NFKS8opjDxFL3AczNYID8B4WfluK+5p
 RM6fNN/52EP8QgYantMwqbSq6MiNO8KngrXg3R8qsy2rePQWVHf4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA3MCBTYWx0ZWRfXyxEJ9dcM6zxK
 GBnrnf5zYfMoYDdg37aRD+SGFvFdtdIZa+6YJZUXVVcS3xLFFIs91JvmunmSGyA8ExBlCdsyj1+
 tWUJ+PMmM9C1+/PJU5++jZVNUjVBs1fc7tk+B0SYvcIR859OXqwRxqPTtSWLIIUgBuJ/8InuaHI
 IF9r1Yn/ZT4qb0r5/HVGkST4zGqEZwG9N/+2oBHTfCmY5zaC93AG7fVM7KtNhYuV8b8no9zJpqI
 poSB7JcvRLoout0BsBwhZmX69Kra+FnJt7Q1fqSFOgPbJta4U9hY0dUofIBj2nYJFvW7RKNWmnv
 uAJ1W307A67ROEONAMgH35CeAg8JPqGDsSk1qHHsU1YL7jCKmAYx3GzRDOxoyKuxlml1pvWlmXc
 CL+nW/rY3sMJcilKKxybuTDhS9TZl+EPGyiD/2egvafYg0xBBrn5D8IkD0VrDOwDWdRazWX1ffD
 cMlCbx9QsGaSkDT/vjg==
X-Proofpoint-ORIG-GUID: RRzeGso8eRodI_DYZAqEpSJOCetIEjn2
X-Proofpoint-GUID: RRzeGso8eRodI_DYZAqEpSJOCetIEjn2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090070

Add a dev->open check at the beginning of cm109_input_ev() to reject
events when the device is not open. There is no point in handling
input events for a device that has not been fully initialized.

The cm109 driver's event callback cm109_input_ev() can be invoked via
kd_mksound() -> input_inject_event() as soon as the input handle is
registered in kbd_connect(), which happens during
input_register_device() before cm109_input_open() has completed.
Without checking dev->open, the callback calls
cm109_toggle_buzzer_async() which submits urb_ctl while
cm109_input_open() is also about to submit the same URB, causing a
'list_add double add' BUG in usb_hcd_link_urb_to_ep().

Two crash scenarios have been observed:

Scenario 1: Same-CPU preemption (CONFIG_PREEMPT=y)

  During input_register_device(), kbd_connect() calls
  input_open_device() which invokes cm109_input_open(). Between
  setting ctl_urb_pending=1 and submitting the URB, the kworker
  thread is preempted by a process writing to a tty (triggering
  kd_mksound). The preempting process calls input_inject_event()
  -> cm109_input_ev() -> cm109_toggle_buzzer_async(), which sees
  ctl_urb_pending=0 (not yet set) and submits urb_ctl. When the
  kworker resumes, it also submits the same urb_ctl.

  CPU 0 (kworker)              CPU 0 (preempting)
  ---------------              ------------------
  input_open():
    // about to set pending=1
    <preempted>
                               input_ev():
                                 toggle_buzzer_async():
                                   ctl_urb_pending == 0
                                   submit_urb(urb_ctl) [1st]
    <resumes>
    ctl_urb_pending = 1
    submit_urb(urb_ctl) [2nd] --> CRASH

Scenario 2: Cross-CPU concurrency

  kbd_connect() has made the device handle visible to kd_mksound
  on CPU 1, but cm109_input_open() on CPU 0 has not yet finished.
  CPU 1 calls cm109_input_ev() first, sees dev->open=0 and
  ctl_urb_pending=0 (device was just kzalloc'd), and submits
  urb_ctl. Shortly after, CPU 0's cm109_input_open() also submits
  the same urb_ctl that is already on the endpoint list.

  CPU 0 (kworker)              CPU 1 (repro)
  ---------------              ---------------
  input_register_device()
    kbd_connect()
      input_register_handle()
                               kd_mksound() sees handle
      input_open_device()        input_ev():
        cm109_input_open():        toggle_buzzer_async():
          // not started yet         ctl_urb_pending == 0
                                     open == 0
                                     submit_urb [1st]
          ctl_urb_pending = 1
          submit_urb [2nd] --> CRASH

In both cases the root cause is that cm109_input_ev() does not
verify the device is open before triggering URB submission. Adding
the open check at function entry prevents the event callback from
racing with cm109_input_open() on URB submission.

Reported-by: syzbot+e69c25cf38a53d0cf64c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e69c25cf38a53d0cf64c
Fixes: c04148f915e5 ("Input: add driver for USB VoIP phones with CM109 chipset")
Signed-off-by: Xue Lei <Xue.Lei@windriver.com>
---
 drivers/input/misc/cm109.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/misc/cm109.c b/drivers/input/misc/cm109.c
index 353d3c1d347d..558cb73d5c6d 100644
--- a/drivers/input/misc/cm109.c
+++ b/drivers/input/misc/cm109.c
@@ -601,6 +601,9 @@ static int cm109_input_ev(struct input_dev *idev, unsigned int type,
 {
 	struct cm109_dev *dev = input_get_drvdata(idev);
 
+	if (!dev->open)
+		return -ENODEV;
+
 	dev_dbg(&dev->intf->dev,
 		"input_ev: type=%u code=%u value=%d\n", type, code, value);
 
-- 
2.43.0

