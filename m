From: Paul Donohue <linux-kernel@PaulSD.com>
Subject: [PATCH v6 0/3] Input: ALPS - Bug fix and cleanup for SS5 hardware
Date: Thu, 24 Nov 2016 09:25:50 -0500
Message-ID: <1479997553-25877-1-git-send-email-linux-kernel@PaulSD.com>
References: <201611111459.12642@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Lepton.TopQuark.net ([168.235.66.66]:40411 "EHLO
        Mail2.TopQuark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965482AbcKXO02 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 24 Nov 2016 09:26:28 -0500
In-Reply-To: <201611111459.12642@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ben Gamari <ben@smart-cactus.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Michal Hocko <mhocko@suse.com>, Paul Donohue <linux-kernel@PaulSD.com>

This series includes a bug fix and assorted cleanup for the Alps SS5
(SS4 v2) code.

Changes in v6:
* Added Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
* No code changes

Changes in v5:
* Moved TrackStick decoding logic to alps_process_packet_ss4_v2() to
  make the code more consistent with other protocol versions
  (Suggested by Pali Roh=C3=A1r <pali.rohar@gmail.com>)

Changes in v4:
* Fixed patch formatting issues
* Correct casting issues in macros added in v3

Changes in v3:
* Added additional code cleanup to make the code easier to understand
  (Suggested by Pali Roh=C3=A1r <pali.rohar@gmail.com>)

Changes in v2:
* For consistency with other Alps functions, check packet bytes for
  packet type rather than adding a flag to alps_fields for packet type.
  (Suggested by Pali Roh=C3=A1r <pali.rohar@gmail.com>)

Paul Donohue (3):
  Input: ALPS - Fix TrackStick support for SS5 hardware
  Input: ALPS - Clean up TrackStick handling for SS5 hardware
  Input: ALPS - Clean up code for SS5 hardware

 drivers/input/mouse/alps.c | 59 +++++++++++++++++++++++++---------------=
------
 drivers/input/mouse/alps.h | 22 ++++++++++++++++-
 2 files changed, 53 insertions(+), 28 deletions(-)

--=20
2.7.4

