From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH 0/2] fix gpio-keys debouncing and timer sleep issues
Date: Fri, 26 Jun 2009 15:15:16 +0300
Message-ID: <cover.1246015395.git.ext-jani.1.nikula@nokia.com>
References: <20090626002345.07928230@dxy.sh.intel.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760213AbZFZMQA@vger.kernel.org>
In-Reply-To: <20090626002345.07928230@dxy.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alek.du@intel.com
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, soni.trilok@gmail.com, ben-linux@fluff.org, ext-phil.2.carmody@nokia.com, ext-jani.1.nikula@nokia.com
List-Id: linux-input@vger.kernel.org

Alek, someone might depend on how debouncing worked before, so let's not 
break it. I, for one, am looking at using this in the future, and would 
want this to work as it was before.

Why don't we fix this instead of debating? For simplicity, here's first 
a revert of the original patch and then a fix to the sleep issue. 
Unfortunately, I do not have the equipment to properly test this right 
now.

Could you please review and test this if you have the equipment? Add 
your signed-off-by and comments, of course. Would that be okay?

BR,
Jani.


Jani Nikula (2):
  Revert "Input: gpio-keys - change timer to workqueue"
  input: gpio-keys: avoid possibility of sleeping in timer function

 drivers/input/keyboard/gpio_keys.c |   33 ++++++++++++++++++++++++---------
 1 files changed, 24 insertions(+), 9 deletions(-)
