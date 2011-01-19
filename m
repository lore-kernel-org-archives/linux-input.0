From: Thomas Chou <thomas@wytron.com.tw>
Subject: Re: Antw:Re: [PATCH] alter_ps2: Add devicetree support
Date: Wed, 19 Jan 2011 10:10:38 +0800
Message-ID: <4D36481E.2090708@wytron.com.tw>
References: <72c0b97741a709.4d35bf01@home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <72c0b97741a709.4d35bf01@home.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: "W.A. GOOSSENS" <waltergoossens@home.nl>
Cc: Grant Likely <grant.likely@secretlab.ca>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, nios2-dev@sopc.et.ntust.edu.tw, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-input@vger.kernel.org

Hi Walter,

On 01/18/2011 11:25 PM, W.A. GOOSSENS wrote:
> I can however create a "fallback" rule were unkown components are just
> added with the names the sopcinfo file, but that should not be the
> default in my opinion since this will very effectively polute the
> namespace in an uncontrolable way.

Great! Do you have proposed name with version for ps2, altera_spi and 
oc_tiny_spi? Then I can work on driver update. I guess we should ground 
the version with "1.0" in driver match table.

Cheers,
Thomas
