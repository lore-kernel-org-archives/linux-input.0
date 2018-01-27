From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] input/joystick/gamecon: Adjustments for gc_attach()
Date: Sat, 27 Jan 2018 17:12:54 +0100
Message-ID: <e02726e3-2ee7-e690-a8ea-90a55f8fd0c2@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Joe Perches <joe@perches.com>, Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 27 Jan 2018 17:07:27 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve a size determination

 drivers/input/joystick/gamecon.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.16.1
