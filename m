From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2 0/6] Input: soc_button_array fixes and support of the
 Surface 3
Date: Fri, 20 May 2016 11:50:26 +0200
Message-ID: <1463737826.3440.40.camel@hadess.net>
References: <1463155554-11747-1-git-send-email-benjamin.tissoires@redhat.com>	
 <1463507131.3440.7.camel@hadess.net>
	 <20160520075348.GI23234@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160520075348.GI23234@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Lejun Zhu <lejun.zhu@linux.intel.com>, Fabio Estevam <festevam@gmail.com>
List-Id: linux-input@vger.kernel.org

On Fri, 2016-05-20 at 09:53 +0200, Benjamin Tissoires wrote:
> 
<snip>
> Bastien told me in a different thread that the power button is not
> working only after a reboot from Windows. After a cold start, it
> works
> fine.

Not quite. It worked after a hot reboot from Windows another time.

>  There might be something that needs to be set at the I2C level,
> but I think while we don't know much about the I2C protocol there, it
> should be safe to still get this upstream.

I don't know what the problem could be, but it seems safe enough for
now.

Cheers
