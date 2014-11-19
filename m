From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: bisected: IR press/release behavior changed in 3.17, repeat
 events
Date: Wed, 19 Nov 2014 20:50:19 +0100
Message-ID: <20141119195019.GA20784@hardeman.nu>
References: <54679469.1010500@openelec.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54679469.1010500@openelec.tv>
Sender: linux-media-owner@vger.kernel.org
To: Stephan Raue <mailinglists@openelec.tv>
Cc: linux-input@vger.kernel.org, m.chehab@samsung.com, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Nov 15, 2014 at 06:59:05PM +0100, Stephan Raue wrote:
>Hi
>
>with kernel 3.17 using a RC6 remote with a buildin nuvoton IR receiver (not
>tested others, but i think its a common problem) when pressing/releasing the
>same button often within 1 second there will no release event sent. Instead
>we get repeat events. To get the release event i must press the same button
>with a delay of ~ 1sec.
>
>the evtest output for kernel with the difference 3.16 and 3.17 looks like

Hi,

could you try the working and non-working versions with debugging output
enabled from the in-kernel rc6 decoder (i.e. set debug for the rc-core
module) and post the two different outputs?

//David
