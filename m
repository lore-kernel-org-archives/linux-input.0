From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RESEND PATCH v6 00/22] power_supply: Allow safe usage of power
 supply
Date: Fri, 13 Mar 2015 14:02:24 +0100
Message-ID: <1426251744.7024.3.camel@AMDC1943>
References: <1426146260-30081-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-reply-to: <1426146260-30081-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-input@vger.kernel.org

On czw, 2015-03-12 at 08:43 +0100, Krzysztof Kozlowski wrote:
> Hi,
> 
> 
> Resending patchset because it was filtered out by vger.kernel.org.
> 
> The patchset fixes invalid memory accesses in certain race scenarios by
> moving ownership of struct power_supply to the core. All drivers are
> modified.

Hi Sebastian,

All necessary folks have responded (Jiri for input, Ingo Molnar for x86,
Rafael for ACPI). Additionally I think it would be the best to merge the
patchset early so it will sit in linux-next for some time.

Can you apply it?

Best regards,
Krzysztof

