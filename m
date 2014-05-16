From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH v4 6/9] regulator: AXP20x: Add support
 for regulators subsystem
Date: Fri, 16 May 2014 09:40:31 +0200
Message-ID: <CAOQ7t2ZrO_yD2W1qtk8aqBD2At6ieW5kmFwAoLQ1EsY144gUkQ@mail.gmail.com>
References: <1397209093-10077-1-git-send-email-carlo@caione.org>
	<1397209093-10077-7-git-send-email-carlo@caione.org>
	<5375015A.10701@free-electrons.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDWJTUUC5UCBB34B26NQKGQECPLN5DA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <5375015A.10701-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, May 15, 2014 at 8:03 PM, Boris BREZILLON
<boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> Hello Carlo,
>
> On 11/04/2014 11:38, Carlo Caione wrote:
>> AXP202 and AXP209 come with two synchronous step-down DC-DCs and five
>> LDOs. This patch introduces basic support for those regulators.
>>
>> Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
>> ---
>>  drivers/regulator/Kconfig            |   7 +
>>  drivers/regulator/Makefile           |   1 +
> [...]
>> +     if (!np)
>> +             return 0;
>> +
>> +     regulators = of_find_node_by_name(np, "regulators");
>
> I know I'm late, and this patch has already been applied, but shouldn't
> we use of_get_child_by_name instead of of_find_node_by_name.
> This might lead to wrong regulators node parsing if other regulators are
> defined in the DT after the axp20x node, because, AFAIK, this function
> searches for DT nodes defined after the specified np node, but not
> necessarely children of the np node.

Right. I'll prepare a fix. Feel free to submit a patch if you want.

Thank you,

-- 
Carlo Caione
