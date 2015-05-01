From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2] input: goodix: Check the 'buffer status' bit before
 reading data
Date: Fri, 01 May 2015 16:13:55 +0200
Message-ID: <1430489635.3945.3.camel@hadess.net>
References: <1430484036-17541-1-git-send-email-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430484036-17541-1-git-send-email-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 2015-05-01 at 14:40 +0200, Paul Cercueil wrote:
> The MSB of the first byte read via I2C at the coordinates address
> indicates whether the data is valid or ready (called "buffer status" 
> in
> the datasheets) when an interrupt is raised. Previously, this bit was
> ignored, which resulted in a lot of incorrect detections of "finger
> removed" events.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Signed-off-by: Bastien Nocera <hadess@hadess.net>
