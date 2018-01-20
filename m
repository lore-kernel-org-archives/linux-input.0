From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] Input-zforce_ts: Adjustments for two function
 implementations
Date: Sat, 20 Jan 2018 21:15:40 +0100
Message-ID: <e36553b1-3221-7944-59bd-6bb9358c488f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko.stuebner@bqreaders.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 20 Jan 2018 21:07:42 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation in zforce_parse_dt()
  Delete an unnecessary return statement in zforce_input_close()

 drivers/input/touchscreen/zforce_ts.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

-- 
2.15.1
