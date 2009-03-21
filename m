From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 12/31] input: Auto-load mousedev module when psaux device opened.
Date: Fri, 20 Mar 2009 22:46:44 -0700
Message-ID: <200903202246.44458.dmitry.torokhov@gmail.com>
References: <cover.1236702228.git.scott@canonical.com> <6c577b415dffe0df86954f2f3971e15a9336d6c6.1236702228.git.scott@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760768AbZCUFr7@vger.kernel.org>
In-Reply-To: <6c577b415dffe0df86954f2f3971e15a9336d6c6.1236702228.git.scott@canonical.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Scott James Remnant <scott@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Scott,

On Tuesday 03 March 2009 07:32:15 Scott James Remnant wrote:
> The mousedev module is missing the char-major-10-1 alias that would cause
> it to be auto-loaded when the /dev/psaux device is opened.  This patch
> adds the alias.
>

I think we are trying to go in the different direction that what you are
proposing - we should automatically load mousedev and other input handlers
when input device that is compatible with that handler is registered with
input core, not the other way around. This way you won't need static device
node in your /dev, udev will create it for you as needed.

Same goes for your other patch.

-- 
Dmitry
